//
//  ApiClient.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    case invalidurl
}

class ApiClient {
    
    func get(url: String) throws -> Single<Data> {
        
        return Single.create { observer -> Disposable in
            guard let url = URL(string: url) else {
                return observer(.error(ApiError.invalidurl)) as! Disposable
            }
            
            Alamofire.request(url, method: .get)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(data))
                    case .failure(let error):
                        observer(.error(error))
                        print(error.localizedDescription)
                    }
                }
            return Disposables.create()
        }
    }
}

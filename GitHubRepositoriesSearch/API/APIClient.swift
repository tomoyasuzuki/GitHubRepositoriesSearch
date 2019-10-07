//
//  APIClient.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/06/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire
import RxSwift

enum ApiError: Error {
    case invalidurl
}

struct ApiClient {    
    func request(url: String) -> Single<Data> {
        return Single.create { observer in
            let disposable = Disposables.create()
            guard let url = URL(string: url) else {
                observer(.error(ApiError.invalidurl))
                return disposable
            }
            
            Alamofire.request(url, method: .get)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(data))
                    case .failure(let error):
                        observer(.error(error))
                    }
            }
            return disposable
        }
    }
}

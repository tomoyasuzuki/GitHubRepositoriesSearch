//
//  APIClient.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/06/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import Foundation

enum ApiError: Error {
    case invalidurl
    case responseError
}

struct ApiClient {    
    func request(url: String) -> Single<Data> {
        return Single.create { observer in
            let disposable = Disposables.create()
            guard let url = URL(string: url) else {
                observer(.error(ApiError.invalidurl))
                return disposable
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let _ = response else {
                    observer(.error(ApiError.responseError))
                    return
                }
                
                observer(.success(data))
            }
            
            task.resume()
            return disposable
        }
    }
}

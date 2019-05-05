//
//  ApiClient.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire
import RxSwift

class ApiClient {
    
    func get(url: String) -> Single<Any> {
        
        return Single.create(subscribe: { observer -> Disposable in
            let url = URL(string: url)
            
            //get request
            Alamofire.request(url!)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        do {
                            observer(.success(utf8Text))
                        } catch {
                            observer(.error(error.localizedDescription as! Error))
                        }
                    }
                })
            return Disposables.create()
        })
    }
}

//
//  APIClient.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/06/29.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

struct ApiClient {    
    func request(url: String ,complition: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            complition(.error(ApiError.invalidurl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let _ = response else {
                complition(.error(ApiError.responseError))
                return
            }
            
            complition(.success(data))
        }
        
        task.resume()
    }
}

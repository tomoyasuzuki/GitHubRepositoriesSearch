//
//  GitHubRepositoriesSearch.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

final class GitHubRepositoriesSearchApi: RequestProtocol {
    private let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
    
    func fetchRepository(queryText: String, complition: @escaping(Result<GitHubSearchRepository, Error>) -> Void) {
        api.request(url: baseUrl + path + queryText + endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let repositories = try JSONDecoder().decode(GitHubSearchRepository.self, from: data)
                    complition(.success(repositories))
                } catch let error {
                    complition(.error(error))
                    print(error.localizedDescription)
                }
            case .error(let error):
                complition(.error(error))
            }
        }
    }
}


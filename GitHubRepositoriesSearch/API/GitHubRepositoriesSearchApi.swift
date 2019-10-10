//
//  GitHubRepositoriesSearch.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift


final class GitHubRepositoriesSearchApi: RequestProtocol {
    private let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
    
    func fetchRepository(queryText: String) -> Single<GitHubSearchRepository> {
        return api.request(url: baseUrl + path + "\(queryText)" + "/repos")
            .map { data in
                try JSONDecoder().decode(GitHubSearchRepository.self, from: data)
        }
    }
}


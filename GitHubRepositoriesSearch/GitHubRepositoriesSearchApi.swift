//
//  GitHubRepositoriesSearch.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift


class GitHubRepositoriesSearchApi {
    
    private let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
    
    func fetchRepository(queryText: String) -> Single<GitHubSearchRepository> {
        print(queryText)
        return api.get(url: "https://api.github.com/users/\(queryText)/repos")
            .do(onSuccess: { (data) in
                print("debug1: \(data)")
            })
            .map { data in
                // JSONをデコードする
                try JSONDecoder().decode(GitHubSearchRepository.self, from: data)
            }
            .do(onSuccess: { (data) in
                print("debug2")
            })
    }
}

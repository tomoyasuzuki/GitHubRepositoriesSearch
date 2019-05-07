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
    
    func fetchRepository(queryText: String) -> Single<GitHubSearchRepositoryElement> {
        // usersの次のパスには検索窓に入力した文字列が入る
        return api.get(url: "https://api.github.com/users/\(queryText)/repos")
            .map { (data) -> GitHubSearchRepositoryElement in
                // JSONをデコードする
                try JSONDecoder().decode(GitHubSearchRepositoryElement.self, from: data)
        }
    }
}

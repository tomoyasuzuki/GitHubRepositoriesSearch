//
//  GitHubRepositoriesSearch.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift

/*
 
 viewmodelは入力のストリームを出力のストリームに変換するだけのシンプルな構成。
 入力を元にmodelに処理を依頼し、modelから返ってきたストリームを出力用のストリームに変換している
 
 */

class GitHubRepositoriesSearchApi: RequestProtocol {
    private let api: ApiClient
    
    init(api: ApiClient) {
        self.api = api
    }
    
    func fetchRepository(queryText: String) -> Single<GitHubSearchRepository> {
        return api.get(url: baseUrl + path + "\(queryText)" + "/repos")
            .map { data in
                // JSONをデコードする
                try JSONDecoder().decode(GitHubSearchRepository.self, from: data)
        }
    }
}

//https://api.github.com/users/\(queryText)/repos"


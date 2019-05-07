//
//  GitHubRepositoriesSearch.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Alamofire
import RxSwift

class GitHubRepositoriesSearchApi: ApiClient {
    
    private let api = ApiClient()
    
    let resultArray: [[String:AnyObject]] = []
    
    func fetchRepository(queryText: String) -> Single<Data> {
        // usersの次のパスには検索窓に入力した文字列が入る
        return api.get(url: "https://api.github.com/users/\(queryText)/repos")
    }
}

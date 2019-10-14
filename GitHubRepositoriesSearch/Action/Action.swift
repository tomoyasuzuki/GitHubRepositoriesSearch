//
//  Action.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/10.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

protocol ActionProtocol {}

struct RepositoryAction: ActionProtocol {
    let repository: [Repository]
    init(repository: [Repository]) {
        self.repository = repository
    }
}


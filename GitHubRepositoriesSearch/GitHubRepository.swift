//
//  GitHubRepository.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/04.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

class GitHubRepository: Codable {
    var name: String
    var html_url: String
    
    init(name: String, html_url: String) {
        self.name = name
        self.html_url = html_url
    }
}

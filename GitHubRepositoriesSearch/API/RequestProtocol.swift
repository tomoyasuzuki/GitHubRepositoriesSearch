//
//  RequestProtocol.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/07.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var endpoint: String { get }
}

extension RequestProtocol {
    var baseUrl: String {
        return "https://api.github.com"
    }

    var path: String {
        return "/users/"
    }
    
    var endpoint: String {
        return "/repos"
    }
}

//
//  Result.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/08.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation

enum Result<T, Error> {
    case success(T)
    case error(Error)
}

enum ApiError: Error {
    case invalidurl
    case responseError
}

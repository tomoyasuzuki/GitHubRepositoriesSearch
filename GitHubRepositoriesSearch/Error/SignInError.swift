//
//  LoginError.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

enum SignInError: Error {
    case emailAndPasswordIsNotMatch
    case userIsNotExists
    
    func message() -> String {
        switch self {
        case .emailAndPasswordIsNotMatch:
            return "email or password may be wrong."
        case .userIsNotExists:
            return "email is wrong."
        }
    }
}

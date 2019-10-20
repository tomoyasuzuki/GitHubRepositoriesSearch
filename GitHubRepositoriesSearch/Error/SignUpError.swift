//
//  SignUpError.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

enum SignUpError: Error {
    case emailIsInvalid
    case passwordIsInvalid
    
    func message() -> String {
        switch self {
        case .emailIsInvalid:
            return "this email account is already exists."
        case .passwordIsInvalid:
            return "password is inivalid."
        }
    }
}

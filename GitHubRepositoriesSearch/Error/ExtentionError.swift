//
//  ExtentionError.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

enum ErrorKind {
    case systemError
    case signInError(SignInError)
    case signUpError(SignUpError)
}

extension Error {
    func message(kind: ErrorKind) -> String {
        switch kind {
        case .signInError(let error):
            return error.message()
        case .signUpError(let error):
            return error.message()
        case .systemError:
            return "system error."
        }
    }
}

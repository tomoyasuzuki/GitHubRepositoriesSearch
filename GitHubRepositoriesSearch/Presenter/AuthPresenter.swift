//
//  AuthPresenter.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/18.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//
import  KeychainAccess

protocol AuthPresenterProtocol {
    func signIn(_ userName: String?, _ email: String?, _ password: String?)
    func signUp(_ userName: String?, _ email: String?, _ password: String?)
    func setView(view: AuthViewProtocol)
}

final class AuthPresenter: AuthPresenterProtocol {
    var view: AuthViewProtocol?
    let keychain: Keychain
    
    init(keychain: Keychain) {
        self.keychain = keychain
    }
    
    func signIn(_ userName: String?, _ email: String?, _ password: String?) {
        guard let _ = userName,
            let email = email,
            let password = password else {
            return
        }
        
        if !email.contains("@") || !email.contains(".") {
            view?.showError(error: SignInError.userIsNotExists, kind: .signInError(.userIsNotExists))
            return
        }
        
        if password.count < 10 {
            view?.showError(error: SignInError.emailAndPasswordIsNotMatch, kind: .signInError(.emailAndPasswordIsNotMatch))
            return
        }
        
        // ログイン処理（サンプルのため省略）
        
        // 画面遷移
        view?.navigateToTop()
    }
    
    func signUp(_ userName: String?, _ email: String?, _ password: String?) {
        guard let _ = userName,
            let email = email,
            let password = password else {
            return
        }
        
        if !email.contains("@") || !email.contains(".") {
            view?.showError(error: SignUpError.emailIsInvalid, kind: .signUpError(.emailIsInvalid))
            return
        }
        
        if password.count < 10 {
            view?.showError(error: SignUpError.passwordIsInvalid, kind: .signUpError(.passwordIsInvalid))
            return
        }
        
        // パスワード変更時などに使用するかもしれない
        do {
            try keychain.set(password, key: KeychainKey.password.rawValue)
            try keychain.set(email, key: KeychainKey.email.rawValue)
        } catch let error {
            view?.showError(error: error, kind: .systemError)
        }
        
        // 登録処理（サンプルのため省略）
        
        // 画面遷移
        view?.navigateToTop()
        
    }
    
    func setView(view: AuthViewProtocol) {
        self.view = view
    }
}

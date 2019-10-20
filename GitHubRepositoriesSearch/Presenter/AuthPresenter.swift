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
        } else if password.count < 10 {
            view?.showError(error: SignInError.emailAndPasswordIsNotMatch, kind: .signInError(.emailAndPasswordIsNotMatch))
            return
        }
       
        do {
            guard let userEmail = try keychain.get(KeychainKey.email.rawValue),
                let userPassword = try keychain.get(KeychainKey.password.rawValue)  else {
                return
            }
          
            if userEmail == email, userPassword == password {
                view?.navigateToTop()
            } else {
                view?.showError(error: SignInError.emailAndPasswordIsNotMatch, kind: .signInError(.emailAndPasswordIsNotMatch))
                return
            }
            
        } catch {
            view?.showError(error: SignInError.userIsNotExists, kind: .signInError(.userIsNotExists))
            return
        }
    }
    
    func signUp(_ userName: String?, _ email: String?, _ password: String?) {
        guard let userName = userName,
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
        
        do {
            try keychain.set(password, key: KeychainKey.password.rawValue)
            try keychain.set(email, key: KeychainKey.email.rawValue)
            
            UserDefaults.standard.set(userName, forKey: "userName")
            
            view?.navigateToTop()
        } catch let error {
            view?.showError(error: error, kind: .systemError)
            return
        }
    }
    
    func setView(view: AuthViewProtocol) {
        self.view = view
    }
}

//
//  AuthViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/18.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit

protocol AuthViewProtocol {
    func showError(error: Error, kind: ErrorKind)
    func navigateToTop()
}

final class AuthViewController: UIViewController, AuthViewProtocol{
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var presenter: AuthPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePresenter()
        configureUI()
    }
    
    @objc func signInButtonTapped() {
        view.endEditing(true)
        
        presenter?.signIn(userNameTextField.text,
                         emailTextField.text,
                         passwordTextField.text)
    }
    
    @objc func signUpButtonTapped() {
        view.endEditing(true)
        
        presenter?.signUp(userNameTextField.text,
                         emailTextField.text,
                         passwordTextField.text)
    }
    
    private func configurePresenter() {
        presenter = AppDelegate.container.resolve(AuthPresenter.self)
        presenter?.setView(view: self)
    }
    
    private func configureUI() {
        wrapView.layer.cornerRadius = 8.0
        wrapView.clipsToBounds = true
        
        signInButton.layer.cornerRadius = 8.0
        signInButton.clipsToBounds = true
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        signUpButton.layer.cornerRadius = 8.0
        signUpButton.clipsToBounds = true
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    func showError(error: Error, kind: ErrorKind) {
        let alert = UIAlertController(title: "Error happend!!", message: error.message(kind: kind), preferredStyle: .alert)
        let cancel = UIAlertAction(title: "close", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToTop() {
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
}

//
//  ViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import Foundation

protocol ViewProtocol {
    func configurePresenter() -> Void
    func reloadData() -> Void
    func showError(error: Error) -> Void
    func setView() -> Void
}

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewProtocol, UISearchBarDelegate {
    
    // MARK: Property
    
    @IBOutlet private var searchBar: UISearchBar!
    
    @IBOutlet private var tableView: UITableView!
    
    private var presenter: PresenterProtocol?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        configurePresenter()
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.countRepos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repos = presenter!.bindRepos()
        cell.textLabel?.text = repos[indexPath.row].name
        cell.detailTextLabel?.text = repos[indexPath.row].url
        
        cell.detailTextLabel?.textColor = UIColor.gray
        return cell
    }
    
    func configurePresenter() {
        presenter = AppDelegate.container.resolve(Presenter.self)
        setView()
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Error happened", preferredStyle:  UIAlertController.Style.alert)
        
        let closeAction = UIAlertAction(title: "close", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.global().async { [weak self] _ in
            self?.presenter!.fetch(text: searchText)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    func setView() {
        guard let presenter = self.presenter else { return }
        presenter.setView(view: self)
    }
}

//
//  ViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: Property
    
    @IBOutlet private var searchBar: UISearchBar!
    
    @IBOutlet private var tableView: UITableView!
    
    private var store: Store!
    private var action: ActionCreator!
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        configureStore()
        configureAction()
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = store.repositories[indexPath.row].name
        cell.detailTextLabel?.text = store.repositories[indexPath.row].url
        
        cell.detailTextLabel?.textColor = UIColor.gray
        return cell
    }
    
    func configureStore() {
        store = AppDelegate.container.resolve(Store.self)
        
        store
            .output
            .subscribe(onNext: { event in
                switch event {
                case .reloadTableView:
                    self.tableView.reloadData()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func configureAction() {
        action = AppDelegate.container.resolve(ActionCreator.self)
        
        action
            .fetch(text: self.searchBar.rx.text.orEmpty.asDriver())
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
    }
}

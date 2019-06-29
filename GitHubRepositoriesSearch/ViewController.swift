//
//  ViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - Property -
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ViewModel? = nil
    
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AppDelegate.container.resolve(ViewModel.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel?.getObservable(observable: searchBar.rx.text.orEmpty.asObservable())
            .subscribe(onNext: { () in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Delegate -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel!.repositories[indexPath.row].name
        cell.detailTextLabel?.text = viewModel!.repositories[indexPath.row].url
        
        cell.detailTextLabel?.textColor = UIColor.gray
        return cell
    }
}


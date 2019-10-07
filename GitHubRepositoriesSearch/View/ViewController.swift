//
//  ViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/03.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Property -
    
    @IBOutlet private var searchBar: UISearchBar!
    
    @IBOutlet private var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ViewModel?
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureViewModel()
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
    
    private func configureViewModel() {
        viewModel = AppDelegate.container.resolve(ViewModel.self)
        
        let input = ViewModel.Input(searchTextDidChange: searchBar.rx.text.orEmpty.asDriver())
        let output = viewModel!.bind(input: input)
        
        output
            .repositories
            .drive(onNext: { _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

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
import RxDataSources

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    let disposeBag = DisposeBag()
    
    var repositories: [[String:String]] = []
    
    // 検索窓を監視対象にする
    // テキストが空の場合はデータ取得を行わない
    var searchBarObservable: Observable<String> {
        return searchBar.rx.text
            .filter { $0 != nil}
            .map { $0!}
            .filter { $0.characters.count > 0 }
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Delegate -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.row]["name"]
        cell.detailTextLabel?.text = repositories[indexPath.row]["html_url"]
        return cell
    }
}


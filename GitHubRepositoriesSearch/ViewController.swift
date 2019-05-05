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

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    let disposeBag = DisposeBag()
    
    /*
 
        カレンダーアプリではAPIを呼び出すのが一回でしかも画面表示時だったのでViewDidLoadに記述したが今回の場合はテキストが変更されるたびにAPIを呼び出す必要があるので、まずは検索窓を監視対象にする。
 
    */
    
    // 検索窓を監視対象にする
    // テキストが空の場合はデータ取得を行わない
    var searchBarObservable: Observable<String> {
        return searchBar.rx.text
            .filter { $0 != nil}
            .map { $0!}
            .filter { $0.characters.count > 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


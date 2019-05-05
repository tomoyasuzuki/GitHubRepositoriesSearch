//
//  ViewModel.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/05.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    // GitHubRepositoriesSearchApi と viewController を使用可能な状態にする（Swinjectで後々DIをする）
    let githubrepositoryApi = GitHubRepositoriesSearchApi()
    
    var viewController = ViewController()
    
    var repositories: [[String:String]] = []
    
    private let reloadSubject:PublishSubject<Void> = PublishSubject<Void>()
    var reloadObservable: Observable<Void> { return reloadSubject.asObservable() }
    
    func getRepository() {
        // 検索窓のイベントを購読
        viewController.searchBarObservable
            .subscribe(onNext: { (queryText) in
                // 検索キーワードに基づいてAPIを叩く
                self.githubrepositoryApi.fetchRepository(queryText: queryText).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                
                
                // データの成形処理が終了したら通知を出す
                self.reloadSubject.onNext(())
            })
    }
}


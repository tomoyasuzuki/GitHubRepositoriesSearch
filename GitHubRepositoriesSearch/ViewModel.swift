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
    
    func getRepository(queryText: String) {
        
        self.githubrepositoryApi.fetchRepository(queryText: queryText).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        /*
         
            データの成形処理（オペレーターなどを使用）
            完了次第 reloadSubject.onNext(()) を実行する
         
         */
        
    }
}


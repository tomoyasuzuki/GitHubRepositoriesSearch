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
    
    //取得したデータを格納する変数
    var repositories: Array = [""]
    
    // 基本的には『データを取得し、成形してViewへ通知を出す』ということをやる
    // その後のViewの変更はViewの責務なのでViewModelでは行わない
    // 具体的には、ViewModelからの通知に基づいてViewはテーブルをリロードする
    // テーブルをリロードするという点に関しては前回と同じなので同じやり方(データの取得と成形が終わったのちSubjectで明示的に通知を出す方法)をやってみる
    // まずはストリームを作る
    private let reloadSubject:PublishSubject<Void> = PublishSubject<Void>()
    var reloadObservable: Observable<Void> { return reloadSubject.asObservable() }
    
    // 検索窓が監視対象なので検索窓のテキストが流れているストリームを購読してonNextでAPIを叩く
    func getRepository() {
        // 検索窓のイベントを購読する
        viewController.searchBarObservable
            .subscribe(onNext: { (queryText) in
                self.githubrepositoryApi.fetchRepository(queryText: queryText).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
                // ------------オペレータなどを使用して成形する-------------
                
                
                
                // 成形が終了したら通知を出す（本来は成形処理の最後に含める）
                self.reloadSubject.onNext(())
            })
    }
}


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
    private let githubrepositoryApi: GitHubRepositoriesSearchApi
    
    private let searchBarObservable: Observable<String>
    
    init(githubrepositoryApi: GitHubRepositoriesSearchApi, searchBarObservable: Observable<String>) {
        self.githubrepositoryApi = githubrepositoryApi
        self.searchBarObservable = searchBarObservable
    }
    
    // 取得したデータを格納する変数
    // Repository型の要素を持つ配列にしたことで、各要素は name と　html を持つ
    var repositories: [Repository] = []
    
    private let reloadSubject:PublishSubject<Void> = PublishSubject<Void>()
    var reloadObservable: Observable<Void> { return reloadSubject.asObservable() } 
    
    func getRepository(queryText: String) {
        self.githubrepositoryApi.fetchRepository(queryText: queryText)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .asObservable() // Single を Observable に変換
            .flatMap { elements -> Observable<GitHubSearchRepositoryElement> in
                Observable.from(elements) // Observable<[GitHubRepositoryElement]>をObservable<GitHubRepositoryElement> に変換
            }
            .map { elements -> Repository in // Observable<GitHubRepositoryElement>をObservable<Repository>に変換
                let repository = Repository(name: elements.name, htmlURL: elements.htmlURL)
                
                return repository
            }
            .toArray() // Observable<Repository>をObservable<[Repository]>に変換
            .asSingle() // Observable<[Repository]>をSingle<[Repository]>に変換
            .subscribe(
                onSuccess: { repositories_in_map in
                    self.repositories = repositories_in_map
                    self.reloadSubject.onNext(())
                },
                onError: { error in
                    print(error)
            })
    }
}


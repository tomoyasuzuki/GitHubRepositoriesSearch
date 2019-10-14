//
//  Store.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/10.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxCocoa
import RxSwift

final class Store {
    private let disposeBag = DisposeBag()
    private let dispatcher: Dispatcher

    var notifyRepository = BehaviorSubject<[Repository]>(value: [])

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        
        let repositories: Observable<RepositoryAction> = self.dispatcher.observe()
        
        repositories.subscribe(onNext: { [weak self] repos in
            self?.notifyRepository.onNext(repos.repository)
        })
        .disposed(by: disposeBag)
    }
}

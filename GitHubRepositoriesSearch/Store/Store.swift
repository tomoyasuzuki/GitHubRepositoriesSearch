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

    var repositories: [Repository] = []
    let output = PublishSubject<ViewOuputEvent>()

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher

        self.dispatcher
            .output
            .subscribe { [weak self] action in
                guard let actionType = action.element else { return }
                switch actionType {
                case let .updateRepository(repos):
                    self?.repositories = repos
                    self?.output.onNext(.reloadTableView)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

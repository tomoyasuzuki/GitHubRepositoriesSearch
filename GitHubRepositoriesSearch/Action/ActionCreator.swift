//
//  ActionCreator.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/10.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxCocoa
import RxSwift

final class ActionCreator {
    private let githubRepositoryApi: GitHubRepositoriesSearchApi
    private let dispatcher: Dispatcher

    init(githubRepositoryApi: GitHubRepositoriesSearchApi, dispatcher: Dispatcher) {
        self.githubRepositoryApi = githubRepositoryApi
        self.dispatcher = dispatcher
    }

    func fetch(text: Driver<String>) -> Observable<Void> {
        return text
            .asObservable()
            .filter { $0.count >= 2 }
            .flatMap { self.githubRepositoryApi.fetchRepository(queryText: $0) }
            .map { elements -> [Repository] in
                elements
                    .map { elements in
                        let repository = Repository(name: elements.name, url: elements.url)
                        return repository
                    }
            }
            .do(onNext: { [weak self] repos in
                self?.dispatcher.dispatch(action: .updateRepository(repos))
            })
            .map { _ in ()}
    }
}

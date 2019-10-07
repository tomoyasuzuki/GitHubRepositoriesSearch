//
//  ViewModel.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/05.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import RxCocoa
import RxSwift

final class ViewModel {
    // MARK: Property
    
    private let githubRepositoryApi: GitHubRepositoriesSearchApi
    
    private let disposeBag = DisposeBag()
    
    var repositories: [Repository] = []
    
    // MARK: Struct
    
    struct Input {
        let searchTextDidChange: Driver<String>
    }
    
    struct Output {
        let repositories: Driver<Void>
    }
    
    // MARK: Init
    
    init(githubRepositoryApi: GitHubRepositoriesSearchApi) {
        self.githubRepositoryApi = githubRepositoryApi
    }
    
    // MARK: Function
    
    func bind(input: Input) -> Output {
        let repositories = input.searchTextDidChange
            .asObservable()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .filter { $0.count >= 2 }
            .flatMap { self.githubRepositoryApi.fetchRepository(queryText: $0) }
            .map { elements -> [Repository] in
                elements
                    .map { elements in
                        let repository = Repository(name: elements.name, url: elements.url)
                        return repository
                    }
            }
            .do(onNext: { repos in
                self.repositories = repos
            })
            .map { _ in () }
            .asDriver(onErrorDriveWith: Driver.empty())
        
        return Output(repositories: repositories)
    }
}

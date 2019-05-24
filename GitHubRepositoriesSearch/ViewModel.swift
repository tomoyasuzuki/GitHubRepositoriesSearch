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
        
        // MARK: - Property -
        
        private let githubrepositoryApi: GitHubRepositoriesSearchApi
        
        private let disposeBag = DisposeBag()
        
        var repositories: [Repository] = []
        
        // MARK: - Init -
        
        init(githubrepositoryApi: GitHubRepositoriesSearchApi) {
            self.githubrepositoryApi = githubrepositoryApi
        }
        
        // MARK: - Method -
        
        func getObservable(observable: Observable<String>) -> Observable<()> {
            return observable
                .debounce(1.0, scheduler: MainScheduler.instance)
                .filter { $0.count >= 2}
                .flatMap { self.githubrepositoryApi.fetchRepository(queryText: $0) }
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
        }
    }

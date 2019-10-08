//
//  ViewModel.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/05/05.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

protocol PresenterProtocol {
    func fetch(text: String) -> Void
    func countRepos() -> Int
    func bindRepos() -> [Repository]
    func setView(view: ViewProtocol) -> Void
}

final class Presenter: PresenterProtocol {
    
    // MARK: Property
    
    var view: ViewProtocol?
    
    private let githubRepositoryApi: GitHubRepositoriesSearchApi
    
    var repositories: [Repository] = []
    
    // MARK: Init
    
    init(githubRepositoryApi: GitHubRepositoriesSearchApi) {
        self.githubRepositoryApi = githubRepositoryApi
    }
    
    // MARK: Function
    
    func fetch(text: String) {
        guard text.count >= 2 else {
            return
        }
        
        self.githubRepositoryApi.fetchRepository(queryText: text) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repos):
                self.repositories.removeAll()
                
                for i in 0..<repos.count {
                    guard let name = repos[i].name, let url = repos[i].url else {
                        return
                    }
                    
                    self.repositories.append(Repository(name: name, url: url))
                }
                
                self.view?.reloadData()
            case .error(let error):
                self.view?.showError(error: error)
            }
        }
    }
    
    func countRepos() -> Int {
        return self.repositories.count
    }
    
    func bindRepos() -> [Repository] {
        return self.repositories
    }
    
    func setView(view: ViewProtocol) {
        self.view = view
    }
}

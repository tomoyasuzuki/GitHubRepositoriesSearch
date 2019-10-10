//
//  Dispatcher.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/10.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class Dispatcher {
    public static let shared = Dispatcher()
    let output = PublishSubject<Action>()
    
    public init() {}
    
    public func dispatch(action: Action) {
        self.output.onNext(action)
    }
}

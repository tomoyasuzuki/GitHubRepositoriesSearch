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
    private let subject = PublishSubject<ActionProtocol>()
    
    public init() {}
    
    public func dispatch(action: ActionProtocol) {
        subject.onNext(action)
    }
    
    public func observe<T: ActionProtocol>() -> Observable<T> {
        return subject.asObservable().compactMap {$0 as? T}
    }
}

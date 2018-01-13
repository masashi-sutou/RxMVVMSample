//
//  EntityModelRepository.swift
//  RxMVVMSample
//
//  Created by 須藤将史 on 2018/01/12.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import Foundation
import RxSwift

protocol EntityModelRepositorable {
    associatedtype P
    associatedtype V
    associatedtype E
    
    func get(by parameters: P) -> RxSwift.Single<Result<V, E>>
}

extension EntityModelRepositorable {
    func asAny() -> EntityModelRepository<P, V, E> {
        return EntityModelRepository(repository: self)
    }
}

final class EntityModelRepository<Parameters, Entity, Reason>: EntityModelRepositorable {
    typealias P = Parameters
    typealias V = Entity
    typealias E = Reason
    
    private let _get: (Parameters) -> RxSwift.Single<Result<V, E>>
    
    init<Repository: EntityModelRepositorable>(repository: Repository) where Repository.P == Parameters, Repository.V == Entity, Repository.E == Reason {
        self._get = { parameters in
            repository.get(by: parameters)
        }
    }
    
    func get(by parameters: P) -> RxSwift.Single<Result<V, E>> {
        return self._get(parameters)
    }
}

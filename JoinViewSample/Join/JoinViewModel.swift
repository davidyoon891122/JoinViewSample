//
//  JoinViewModel.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/9/24.
//

import Foundation
import Combine

struct JoinViewModel {
    
    struct Inputs {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Outputs {
        let events: AnyPublisher<Void, Never>
        let items: AnyPublisher<[JoinDataItem], Never>
    }
    
}

extension JoinViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let joinItemPublisher = PassthroughSubject<[JoinDataItem], Never>()
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad.handleEvents(receiveOutput: { _ in
                joinItemPublisher.send([.init(section: .name, items: .name(JoinNameCellViewModel()))])
            })
                .map { _ in }
                .eraseToAnyPublisher()
        )
            .eraseToAnyPublisher()
        
        return .init(events: events, items: joinItemPublisher.eraseToAnyPublisher())
    }
    
}

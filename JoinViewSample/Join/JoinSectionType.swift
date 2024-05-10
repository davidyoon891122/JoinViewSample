//
//  JoinSectionType.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/10/24.
//

import Foundation

enum JoinSectionType: CaseIterable {
    case phoneNumber
    case carrier
    case identifier
    case name
}

struct JoinDataItem {
    let section: JoinSectionType
    let items: JoinItemType
}

enum JoinItemType: Hashable {
//    case phoneNumber()
//    case carrier()
//    case identifier()
    case name(JoinNameCellViewModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .name(let viewModel):
            hasher.combine(viewModel)
        }
    }
    
    
}


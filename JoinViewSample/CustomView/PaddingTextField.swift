//
//  PaddingTextField.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/10/24.
//

import UIKit

final class PaddingTextField: UITextField {
    
    private let edge: UIEdgeInsets
    
    init(edge: UIEdgeInsets) {
        self.edge = edge
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edge)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edge)
    }
    
}

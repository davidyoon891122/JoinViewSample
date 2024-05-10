//
//  JoinNameCellView.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/10/24.
//

import UIKit
import SnapKit
import Combine

final class JoinNameCellView: UITableViewCell {
    
    static let identifier = String(describing: JoinNameCellView.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var nameTextField: PaddingTextField = {
        let textField = PaddingTextField(edge: .init(top: 16, left: 16, bottom: 16, right: 16))
        textField.placeholder = "예) 김한화"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel,
            self.nameTextField
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        self.nameTextField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    
    
    func setupCell(viewModel: JoinNameCellViewModel) {
        self.setupViews()
    }
    
}

private extension JoinNameCellView {
    
    func setupViews() {
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
}

#Preview {
    JoinNameCellView()
}

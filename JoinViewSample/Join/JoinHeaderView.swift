//
//  JoinHeaderView.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/9/24.
//

import UIKit
import SnapKit

final class JoinHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = String(describing: JoinHeaderView.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "본인인증을 위해\n정보를 입력해주세요"
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension JoinHeaderView {
    
    func setupViews() {
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


#Preview {
    JoinHeaderView()
}

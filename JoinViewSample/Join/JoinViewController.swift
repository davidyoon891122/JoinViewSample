//
//  JoinViewController.swift
//  JoinViewSample
//
//  Created by Davidyoon on 5/9/24.
//

import Foundation
import UIKit
import Combine
import SnapKit

final class JoinViewController: UIViewController {
    
    private var cancellables: Set<AnyCancellable> = []
    private let viewDidLoadPublisher: PassthroughSubject<Void, Never> = .init()
    
    private let viewModel: JoinViewModel
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        
        return button
    }()
    
    private lazy var topInfoView: UIView = {
        let view = UIView()
        
        [
            self.backButton
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(
            JoinHeaderView.self,
            forHeaderFooterViewReuseIdentifier: JoinHeaderView.identifier
        )
        
        tableView.register(
            JoinNameCellView.self,
            forCellReuseIdentifier: JoinNameCellView.identifier
        )
        
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<JoinSectionType, JoinItemType>  = {
        .init(tableView: self.tableView, cellProvider: { tableView, indexPath, item in
            
            switch item {
            case .name(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: JoinNameCellView.identifier, for: indexPath) as? JoinNameCellView else { return UITableViewCell() }
                return cell
            }
            
        })
    }()
    
    init(viewModel: JoinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewModel()
        self.viewDidLoadPublisher.send()
    }
    
}

extension JoinViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: JoinHeaderView.identifier) as? JoinHeaderView else { return nil }
            return headerView
        } else {
            return nil
        }
    }
    
}

private extension JoinViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        [
            self.topInfoView,
            self.tableView
        ]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.topInfoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
    }
    
    func bindViewModel() {
        let outputs = self.viewModel.bind(.init(viewDidLoad: self.viewDidLoadPublisher.eraseToAnyPublisher()))
        
        [
            outputs.events.sink(receiveValue: { _ in }),
            outputs.items.sink(receiveValue: { [weak self] items in
                self?.applySnapshot(data: items)
            })
        ]
            .forEach {
                self.cancellables.insert($0)
            }
    }
    
    func applySnapshot(data: [JoinDataItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<JoinSectionType, JoinItemType>()
        snapshot.appendSections(JoinSectionType.allCases)
        
        data.forEach { item in
            snapshot.appendItems([item.items], toSection: item.section)
        }
    }
    
}

#Preview {
    JoinViewController(viewModel: JoinViewModel())
}

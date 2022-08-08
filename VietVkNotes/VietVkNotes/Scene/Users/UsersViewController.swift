//
//  UsersViewController.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit
import Reusable
import Combine
import Defaults

class UsersViewController: UIViewController, Bindable {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: UsersViewModel!
    var cancelBag = CancelBag()
    
    private var output: UsersViewModel.Output!
    private var usersPulisher = PassthroughSubject<Void, Never>()
    private let selectUserTrigger = PassthroughSubject<IndexPath, Never>()
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.do {
            $0.register(cellType: UserCell.self)
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func bindViewModel() {
        let input = UsersViewModel.Input(
            loadTrigger: Driver.just(()),
            selectTrigger: selectUserTrigger.asDriver()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        output.$users
            .sink(receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.users = users
                self.tableView.reloadData()
            })
            .store(in: cancelBag)
    }
    
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectUserTrigger.send(indexPath)
    }
}

// MARK: - UITableViewDatasource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(for: indexPath, cellType: UserCell.self).then {
            $0.bindViewModel(users[indexPath.row])
        }
    }
}


extension UsersViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

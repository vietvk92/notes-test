//
//  UserDetailViewController.swift
//  VietVkNotes
//
//  Created by VietVk on 08/08/2022.
//

import UIKit
import Reusable
import Combine

class UserDetailViewController: UIViewController, Bindable {
    
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var numberOfNotes: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: UserDetailViewModel!
    var cancelBag = CancelBag()
    
    private var output: UserDetailViewModel.Output!
    
    private var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        userInfoLabel.text = viewModel.user.userName
        tableView.do {
            $0.register(cellType: NoteCell.self)
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func bindViewModel() {
        let input = UserDetailViewModel.Input(
            loadTrigger: Driver.just(())
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        
        output.$notes
            .sink(receiveValue: { [weak self] notes in
                guard let self = self else { return }
                self.notes = notes
                self.tableView.reloadData()
                let prefix = (notes.count > 1) ? "Notes" : "Note"
                self.numberOfNotes.text = "\(notes.count) \(prefix)"
            })
            .store(in: cancelBag)
    }

}

// MARK: - UITableViewDelegate
extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDatasource
extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(for: indexPath, cellType: NoteCell.self).then {
            $0.bindViewModel(notes[indexPath.row])
        }
    }
}


extension UserDetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

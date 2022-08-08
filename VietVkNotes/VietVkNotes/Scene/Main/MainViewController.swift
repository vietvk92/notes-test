//
//  MainViewController.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit
import Reusable
import Combine
import Defaults

class MainViewController: UIViewController, Bindable {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createButton: UIButton! {
        didSet {
            createButton.addTarget(self, action: #selector(onCreateNote), for: .touchUpInside)
        }
    }
    @IBOutlet weak var otherButton: UIButton! {
        didSet {
            otherButton.addTarget(self, action: #selector(onShowUserList), for: .touchUpInside)
        }
    }
    
    var viewModel: MainViewModel!
    var cancelBag = CancelBag()
    
    private var output: MainViewModel.Output!
    private var notesPulisher = PassthroughSubject<Void, Never>()
    private var createNotesPulisher = PassthroughSubject<Void, Never>()
    private var userListPulisher = PassthroughSubject<Void, Never>()
    
    private var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesPulisher.send()
    }
    
    private func setupView() {
        tableView.do {
            $0.register(cellType: NoteCell.self)
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
        }
        userName.text = Defaults[.user]?.userName ?? ""
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(
            loadTrigger: notesPulisher.eraseToAnyPublisher(),
            createNoteTrigger: createNotesPulisher.eraseToAnyPublisher(),
            userListTrigger: userListPulisher.eraseToAnyPublisher()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        
        output.$notes
            .sink(receiveValue: { [weak self] notes in
                guard let self = self else { return }
                self.notes = notes
                self.tableView.reloadData()
            })
            .store(in: cancelBag)
    }

}

// MARK: - Actions
extension MainViewController {
    @objc func onCreateNote() {
        createNotesPulisher.send()
    }
    
    @objc func onShowUserList() {
        userListPulisher.send()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDatasource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(for: indexPath, cellType: NoteCell.self).then {
            $0.bindViewModel(notes[indexPath.row])
        }
    }
}

extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

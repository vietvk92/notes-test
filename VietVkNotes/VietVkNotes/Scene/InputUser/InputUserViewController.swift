//
//  InputUserViewController.swift
//  VietVkNotes
//
//  Created by VietVk on 06/08/2022.
//

import UIKit
import Reusable
import Combine

class InputUserViewController: UIViewController, Bindable {
    
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.delegate = self
        }
    }
    
    var viewModel: InputUserViewModel!
    var cancelBag = CancelBag()
    
    private var currentText: String = ""
    private var output: InputUserViewModel.Output!
    private var inputUserPublisher = PassthroughSubject<String, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        userNameTextField.becomeFirstResponder()
        userNameTextField.textPublisher.sink { [weak self] text in
            self?.currentText = text
        }
        .store(in: cancelBag)
    }
    
    func bindViewModel() {
        let input = InputUserViewModel.Input(inputUserTrigger: inputUserPublisher.eraseToAnyPublisher())
        let output = viewModel.transform(input, cancelBag: cancelBag)
        output.$alert.subscribe(alertSubscriber)
        output.$isLoading.subscribe(loadingSubscriber)
    }
    
}

extension InputUserViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

extension InputUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    func performAction() {
        inputUserPublisher.send(currentText)
    }
}

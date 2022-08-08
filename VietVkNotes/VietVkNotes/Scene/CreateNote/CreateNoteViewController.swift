//
//  CreateNoteViewController.swift
//  VietVkNotes
//
//  Created by VietVk on 07/08/2022.
//

import UIKit
import Reusable
import Combine


class CreateNoteViewController: UIViewController, Bindable {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.delegate = self
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.addTarget(self, action: #selector(onSave), for: .touchUpInside)
        }
    }
    var placeholderLabel : UILabel!
    
    var viewModel: CreateNoteViewModel!
    var cancelBag = CancelBag()
    
    private var content: (String, String) = ("", "")
    private var output: CreateNoteViewModel.Output!
    private var createNotePublisher = PassthroughSubject<(String, String), Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {

        saveButton.isEnabled = false
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Enter content text..."
        placeholderLabel.font = .italicSystemFont(ofSize: (contentTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        contentTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contentTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
        
        titleTextField.textPublisher.sink { [weak self] text in
            self?.content.0 = text
            self?.saveButton.isEnabled = !text.isEmpty
        }
        .store(in: cancelBag)
    }
    
    func bindViewModel() {
        let input = CreateNoteViewModel.Input (
            createNoteTrigger: createNotePublisher.eraseToAnyPublisher()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        output.$isDismiss.subscribe(dismissSubscriber)
    }

}

extension CreateNoteViewController {
    
    @objc func onSave() {
        createNotePublisher.send(content)
    }
    
    @objc func onClose() {
        self.dismiss(animated: true)
    }
}

extension CreateNoteViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}

extension CreateNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        self.content.1 = textView.text
    }
}

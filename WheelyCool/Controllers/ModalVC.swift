//
//  AddModalView.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 9/3/2022.
//

protocol ModalVCDelegate {
  func addOption(_ sender: String)
}

import UIKit

class ModalVC: UIViewController {
  // MARK: - Variable and Constant Definitions
  var delegate: ModalVCDelegate?
  
  // individual elements
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    label.textAlignment = .center
    label.text = "New Option"
    return label
  }()
  
  private let textInput: UITextField = {
    let input = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    input.placeholder = "Enter your option here"
    input.font = UIFont.systemFont(ofSize: 14)
    input.borderStyle = UITextField.BorderStyle.roundedRect
    input.clearButtonMode = UITextField.ViewMode.whileEditing
    return input
  }()
  
  private let addButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle("Add", for: .normal)
    button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    
    // NOTE: overrides RoundedButton - could make another button type?
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    return button
  }()
  
  private let cancelButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle("Cancel", for: .normal)
    button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    
    // NOTE: overrides RoundedButton - could make another button type?
    button.backgroundColor = .lightGray
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    return button
  }()
  
  // stacks and containers
  private lazy var buttonStackH: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [cancelButton, addButton])
    stack.distribution = .fillEqually
    stack.alignment = .fill
    stack.axis = .horizontal
    stack.spacing = 15
    return stack
  }()
  
  private lazy var primaryStackV: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [titleLabel, textInput, buttonStackH])
    stack.distribution = .fillEqually
    stack.alignment = .fill
    stack.axis = .vertical
    stack.spacing = 15
    return stack
  }()
  
  private let containerView: UIView = {
    let container = UIView()
    container.backgroundColor = .systemBackground
    container.layer.cornerRadius = 24
    return container
  }()
  
  
  // MARK: - View Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textInput.delegate = self
    
    // background mask
    view.backgroundColor = .systemGray.withAlphaComponent(0.7)
    
    view.addSubview(containerView)
    containerView.addSubview(primaryStackV)
    
    positionContainerView()
    positionPrimaryStack(within: containerView.safeAreaLayoutGuide)
  }
  
  
  // MARK: - Button Actions
  // NOTE: maybe could abstract the button click to 1 method instead of 2
  @objc func addButtonClicked() {
    dismiss(animated: true) {
      self.delegate?.addOption(self.textInput.text ?? "")
    }
  }
  
  @objc func cancelButtonClicked() {
    dismiss(animated: true)
  }
  
  
  // MARK: - AutoConstraint Layouts
  func positionContainerView() {
    NSLayoutConstraint.activate([
      containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    containerView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func positionPrimaryStack(within parentView: UILayoutGuide) {
    NSLayoutConstraint.activate([
      primaryStackV.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 30),
      primaryStackV.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -30),
      primaryStackV.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 30),
      primaryStackV.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -30)
    ])
    primaryStackV.translatesAutoresizingMaskIntoConstraints = false
  }
  
}


// MARK: - TextFieldDelegate Methods
extension ModalVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    addButtonClicked()
    return true;
  }
  
}

//
//  OptionsVC.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 9/3/2022.
//

import UIKit

class OptionsVC: UIViewController {
  // MARK: - Variable and Constant Definitions
  private let tableView = UITableView()
  private let cellID = "OptionCell"
  
  private let nextButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle("Let's roll!", for: .normal)
    button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    return button
  }()
  
  // set up datasource for tableView
  private let userDefaults = UserDefaults.standard
  private let optionsKey = "OptionsList"
  private var options: [String] = []
  
  
  // MARK: - View Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "My Options"
    view.backgroundColor = .systemBackground
    
    view.addSubview(tableView)
    view.addSubview(nextButton)
    
    configureNavBar()
    configureTableView(within: view.safeAreaLayoutGuide)
    configureDoneButton(within: view.safeAreaLayoutGuide)
    
    // get stored data
    options = userDefaults.object(forKey: optionsKey) as? [String] ?? []
  }
  
  
  // MARK: - NavBar Configuration
  func configureNavBar() {
    let scrollEdgeAppearance = UINavigationBarAppearance()
    scrollEdgeAppearance.backgroundColor = .secondarySystemBackground
    navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    
    let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
    addBtn.tintColor = K.brandColours.primary
    navigationItem.rightBarButtonItem = addBtn
  }
  
  
  // MARK: - Button Actions
  @objc func addButtonClicked() {
    let modalVC = ModalVC()
    modalVC.modalPresentationStyle = .overCurrentContext
    modalVC.modalTransitionStyle = .crossDissolve
    modalVC.delegate = self
    self.present(modalVC, animated: true, completion: nil)
  }
  
  @objc func nextButtonClicked() {
    let wheelVC = WheelVC()
    wheelVC.modalPresentationStyle = .fullScreen
    wheelVC.options = options
    navigationController?.pushViewController(wheelVC, animated: true)
  }
  
  
  // MARK: - AutoConstraint Layouts
  func configureTableView(within safeArea: UILayoutGuide) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(OptionCell.self, forCellReuseIdentifier: cellID)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10).isActive = true
    
    tableView.rowHeight = 60
  }
  
  func configureDoneButton(within safeArea: UILayoutGuide) {
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    nextButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.6).isActive = true
    nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    nextButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
  }
  
}


// MARK: - TableView Delegate and DataSource Methods
extension OptionsVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! OptionCell
    let option = options[indexPath.row]
    cell.set(option: option)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      options.remove(at: indexPath.row)
      userDefaults.set(options, forKey: optionsKey)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}


// MARK: - ModalVC Delegate Methods
extension OptionsVC: ModalVCDelegate {
  
  func addOption(_ sender: String) {
    guard (sender != "") else { return }
    
    options.insert(sender, at: 0)
    userDefaults.set(options, forKey: optionsKey)
    tableView.reloadData()
  }
  
}

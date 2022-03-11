//
//  WheelVC.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 9/3/2022.
//

import UIKit
import QuartzCore

class WheelVC: UIViewController {
  // MARK: - Variable and Constant Definitions
  
  // NOTE: options are passed through from OptionsVC
  //       alternatively, these could be taken directly from userDefaults
  var options: [String] = []
  
  private var currentAngle: Double = 0
  private var sectionAngle: Double {
    return 2.0 * Double.pi / Double(options.count)
  }
  
  private let wheelContainer = UIView()
  private let wheel = WheelView()
  
  private var pointer = PointerImageView(image: UIImage(systemName: "arrowtriangle.left.fill"))
  
  private let spinButton: RoundedButton = {
    let button = RoundedButton()
    button.setTitle("Spin me :)", for: .normal)
    button.addTarget(self, action: #selector(spinButtonClicked), for: .touchUpInside)
    return button
  }()
  
  
  // MARK: - View Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    // initial component setup
    view.backgroundColor = .systemBackground
    
    // add subviews
    view.addSubview(wheelContainer)
    wheelContainer.addSubview(wheel)
    view.addSubview(pointer)
    view.addSubview(spinButton)
    
    // position subviews
    positionWheelContainer(within: view.safeAreaLayoutGuide)
    positionWheel(within: wheelContainer.safeAreaLayoutGuide)
    positionPointer(within: wheelContainer.safeAreaLayoutGuide)
    positionSpinButton(within: view.safeAreaLayoutGuide)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    // configure wheel view layout to suit screen size
    updateCornerRadius(for: wheel)
    addCenterCircle(to: wheel)
    
    // add options to the wheel
    for (index, option) in options.enumerated().reversed() {
      // create label
      let optionLabel = PaddedLabel()
      optionLabel.text = option
      wheel.addSubview(optionLabel)
      
      // position label
      NSLayoutConstraint.activate([
        optionLabel.heightAnchor.constraint(equalToConstant: 20),
        optionLabel.widthAnchor.constraint(equalToConstant: wheel.bounds.width / 2.0),
        optionLabel.centerXAnchor.constraint(equalTo: wheel.centerXAnchor),
        optionLabel.centerYAnchor.constraint(equalTo: wheel.centerYAnchor)
      ])
      optionLabel.translatesAutoresizingMaskIntoConstraints = false
      
      // rotate label
      optionLabel.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
      optionLabel.transform = optionLabel.transform.rotated(by: sectionAngle * Double(index))
    }
    
  }
  
  
  // MARK: - Button Actions
  @objc func spinButtonClicked() {
    guard options.count != 0 else { return }
    
    let fullSpins = 6.0 * Double.pi
    let randomAngle = Double(Int.random(in: 0..<options.count)) * sectionAngle
    let newAngle = currentAngle + fullSpins + randomAngle
    
    animate(wheel, from: currentAngle, to: newAngle)
    currentAngle = newAngle
  }
  
  func animate(_ view: UIView, from fromValue: Double, to toValue: Double) {
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.duration = 2.0
    animation.fromValue = fromValue
    animation.toValue = toValue
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    animation.fillMode = CAMediaTimingFillMode.forwards;
    animation.isRemovedOnCompletion = false;
    
    view.layer.add(animation, forKey: nil)
  }
  
  
  // MARK: - AutoConstraint layouts
  func positionWheelContainer(within parentView: UILayoutGuide) {
    NSLayoutConstraint.activate([
      wheelContainer.topAnchor.constraint(equalTo: parentView.topAnchor),
      wheelContainer.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
      wheelContainer.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
      wheelContainer.bottomAnchor.constraint(equalTo: spinButton.topAnchor, constant: -10)
    ])
    wheelContainer.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func positionWheel(within parentView: UILayoutGuide) {
    NSLayoutConstraint.activate([
      wheel.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.9),
      wheel.heightAnchor.constraint(equalTo: wheel.widthAnchor),
      wheel.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
      wheel.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
    ])
    wheel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func positionPointer(within parentView: UILayoutGuide) {
    NSLayoutConstraint.activate([
      pointer.widthAnchor.constraint(equalToConstant: 30),
      pointer.heightAnchor.constraint(equalTo: pointer.widthAnchor),
      pointer.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -3),
      pointer.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
    ])
    pointer.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func positionSpinButton(within parentView: UILayoutGuide) {
    NSLayoutConstraint.activate([
      spinButton.heightAnchor.constraint(equalToConstant: 50),
      spinButton.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.6),
      spinButton.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
      spinButton.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
    ])
    spinButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  // MARK: - View Manipulation Methods
  // NOTE: not sure where these should go
  // TODO: allow for changing device orientation
  
  func addCenterCircle(to parentView: UIView) {
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x: parentView.frame.width / 2 - 8, y: parentView.frame.width / 2 - 8, width: 16, height: 16)
    gradient.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]
    gradient.type = .radial
    gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.cornerRadius = gradient.frame.width / 2
    gradient.borderColor = UIColor.systemOrange.cgColor
    gradient.borderWidth = 2
    parentView.layer.addSublayer(gradient)
  }
  
  func updateCornerRadius(for view: UIView) {
    view.layer.cornerRadius = view.bounds.width / 2
  }
  
}

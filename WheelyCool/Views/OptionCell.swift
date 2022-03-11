//
//  OptionCell.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 9/3/2022.
//

import UIKit

class OptionCell: UITableViewCell {
  private var optionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(optionLabel)
    positionLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func positionLabel() {
    NSLayoutConstraint.activate([
      optionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      optionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      optionLabel.heightAnchor.constraint(equalToConstant: 40),
      optionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
    ])
    optionLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK: - External methods
  func set(option: String) {
    optionLabel.text = option
  }
}

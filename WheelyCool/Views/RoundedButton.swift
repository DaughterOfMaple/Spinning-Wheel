//
//  RoundedButton.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 10/3/2022.
//

import UIKit

class RoundedButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = 10
    layer.masksToBounds = true
    backgroundColor = K.brandColours.primary
    setTitleColor(.systemGray6, for: .normal)
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

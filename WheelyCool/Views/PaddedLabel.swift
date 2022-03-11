//
//  PaddedLabel.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 10/3/2022.
//

import UIKit

class PaddedLabel: UILabel {
  
  required init() {
    super.init(frame: CGRect.zero)
    
    font = .systemFont(ofSize: 14)
    textAlignment = .right
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 15)
    super.drawText(in: rect.inset(by: insets))
  }
  
}

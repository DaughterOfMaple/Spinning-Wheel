//
//  WheelView.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 9/3/2022.
//

import UIKit

class WheelView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = K.brandColours.secondary
    layer.borderWidth = 3
    layer.borderColor = UIColor.darkGray.cgColor
    clipsToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

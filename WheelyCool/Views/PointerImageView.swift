//
//  Pointer.swift
//  WheelyCool
//
//  Created by Carly Mapleson on 10/3/2022.
//

import UIKit

class PointerImageView: UIImageView {

  override init(image: UIImage?) {
    super.init(image: image)
    
    tintColor = K.brandColours.primary
    layer.shadowColor = UIColor.darkGray.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 1.0
    layer.shadowRadius = 1.5
    clipsToBounds = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

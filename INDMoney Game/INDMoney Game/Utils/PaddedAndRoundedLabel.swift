//
//  PaddedAndRoundedLabel.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//

import UIKit

class PaddingAndRoundedLabel: UILabel {
    
    var heightPadding: CGFloat = 10
    var widthPadding: CGFloat = 10
    
    override var intrinsicContentSize: CGSize {
        let originalIntrinsicContentSize = super.intrinsicContentSize
        let height = originalIntrinsicContentSize.height + heightPadding
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalIntrinsicContentSize.width + widthPadding, height: height)
    }
    
}

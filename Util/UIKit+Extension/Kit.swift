//
//  Kit.swift
//  v2ex
//
//  Created by wiley on 2019/12/11.
//  Copyright © 2019 wiley. All rights reserved.
//

import UIKit

open class NiblessView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "loading this view from a nib is unsupported")
    public required init?(coder: NSCoder) {
        fatalError("loading this view from a nib is unsupported")
    }
}

extension UIColor {

    public convenience init(rgb: Int, alpha: CGFloat = 1) {
        
        let red = CGFloat(((rgb & 0xff0000) >> 16)) / 255.0
        let green = CGFloat(((rgb & 0xff00) >> 8)) / 255.0
        let blue = CGFloat(((rgb & 0xff))) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CGFloat {
    
    public static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    public static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}

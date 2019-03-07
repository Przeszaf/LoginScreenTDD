//
//  LoginTextFieldTest.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = Constants.LoginScreen.loginFieldColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var placeholder: String? {
        willSet {
            guard let newValue = newValue else { return }
            attributedPlaceholder = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: Constants.LoginScreen.loginFieldColor])
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        Constants.LoginScreen.loginFieldColor.setStroke()
        path.lineWidth = 2
        path.stroke()
        
    }
    
}

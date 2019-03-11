//
//  LoginButton.swift
//  LoginScreenTDD
//
//  Created by Przemek Szafulski on 11/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoginButton: LoadingButton {
    
    var savedTitle: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.red
        self.setTitleColor(.white, for: .normal)
    }
    
    override func startLoading(style: UIActivityIndicatorView.Style) {
        savedTitle = title(for: .normal)
        super.startLoading(style: style)
        setTitle(nil, for: .normal)
    }
    
    override func stopLoading() {
        super.stopLoading()
        setTitle(savedTitle, for: .normal)
    }
    
    override var isEnabled: Bool {
        didSet {
            if (isEnabled == true) {
                self.alpha = 1
            } else {
                self.alpha = 0.5
            }
        }
    }
}

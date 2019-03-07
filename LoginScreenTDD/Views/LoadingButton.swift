//
//  LoadingButton.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoadingButton: UIButton {
    
    let activityIndicator = UIActivityIndicatorView(style: .white)
    
    func startLoading(style: UIActivityIndicatorView.Style) {
        activityIndicator.style = style
        addSubview(activityIndicator)
        constraintToCenter(subview: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    
    private func constraintToCenter(subview: UIView) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let constraintX = NSLayoutConstraint(item: subview, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let constraintY = NSLayoutConstraint(item: subview, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraints([constraintX, constraintY])
        layoutIfNeeded()
    }
}

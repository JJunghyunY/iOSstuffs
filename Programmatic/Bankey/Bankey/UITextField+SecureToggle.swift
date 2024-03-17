//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Junyoo on 3/17/24.
//

import UIKit

extension UITextField {
    func enablePasswordToggle() {
        let passwordToggleButton = UIButton(type: .custom)

        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView() {
        self.isSecureTextEntry.toggle()
        if let button = self.rightView as? UIButton {
            button.isSelected.toggle()
        }
    }
}

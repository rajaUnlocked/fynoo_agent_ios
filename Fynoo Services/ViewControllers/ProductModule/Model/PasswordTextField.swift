//
//  TxtField.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 25/01/22.
//  Copyright © 2022 Sendan. All rights reserved.
//

import Foundation
import UIKit
class PasswordTextField: UITextField {

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
                //MARK:- Do something what you want
            }
        }
    }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
         return success
    }
}

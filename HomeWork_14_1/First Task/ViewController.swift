//
//  ViewController.swift
//  HomeWork_14_1
//
//  Created by Vlad Ralovich on 8/13/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self

        firstNameTextField.text = Persistance.share.firstUserName
        lastNameTextField.text = Persistance.share.lastUserName
    }
}

 extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameTextField  {
                lastNameTextField?.becomeFirstResponder()
        } else if textField == lastNameTextField {
                Persistance.share.firstUserName = firstNameTextField.text
                Persistance.share.lastUserName = lastNameTextField.text
                lastNameTextField.resignFirstResponder()
            }
        return true
    }
}

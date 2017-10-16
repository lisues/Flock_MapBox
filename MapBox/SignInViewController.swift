//
//  ViewController.swift
//  MapBox
//
//  Created by Lisue Jocelyn She on 10/16/17.
//  Copyright © 2017 Lisue Jocelyn She. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var errorInfo: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var keyboardOnScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorInfo.isHidden = true
        username.delegate = self
        password.delegate = self
        
        subscribeNotification(.UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        subscribeNotification(.UIKeyboardWillHide, selector: #selector(keyboardWillHide))
        subscribeNotification(.UIKeyboardDidShow, selector: #selector(keyboardDidShow))
        subscribeNotification(.UIKeyboardDidHide, selector: #selector(keyboardDidHide))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeAllNotification()
    }
    
    
    @IBAction func submit(_ sender: Any) {
        print("we are submitting the form")
        
        if (username.text?.characters.count)! < 8 {
            errorOutput( message: "The username is at least 8 characters in length" )
            if username.text?.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
                errorOutput( message: "The username is in alphabetic" )
            }
        } else if (password.text?.characters.count)! < 8 {
            errorOutput( message: "The password is at least 8 characters in length" )
        } else {
            //go to next view
            username.text = ""
            password.text = ""
            errorInfo.text = ""
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
            self.present(controller, animated: true, completion: nil)
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        if !keyboardOnScreen  {
            view.frame.origin.y -= keyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if keyboardOnScreen  {
            view.frame.origin.y += keyboardHeight(notification)
        }
    }
    
    func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
        
    }
    
    func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    private func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    private func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    
    func subscribeNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeAllNotification() {
        NotificationCenter.default.removeObserver(self)
    }

    func errorOutput( message: String ) {
       errorInfo.isHidden = false
       errorInfo.text = message
    }
}


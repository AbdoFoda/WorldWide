//
//  ViewController.swift
//  worldWide
//
//  Created by Abdo on 10/16/18.
//  Copyright © 2018 Abdo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
   
    //MARK:- Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK:- Outlet Action
    var waitingForResponse = false
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if(waitingForResponse){
            return
        }
        // here we could use mutex lock!
        DispatchQueue.global().sync {
            waitingForResponse = true
        }
        Repository.loginUser(withEmail: emailTextField.text!, withPassword: passwordTextField.text!, success: { (_) in
            self.performSegue(withIdentifier: "loginSegueID", sender: self)
            DispatchQueue.global().sync {
                self.waitingForResponse = true
            }
        }) { (error) in
            DispatchQueue.global().sync {
                self.waitingForResponse = false
            }
            self.presentSimpleMessage(title: "Warning", message: error.localizedDescription)
        }
    }
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        

}

extension UIViewController : UITextFieldDelegate {
    func presentSimpleMessage(title :String , message :String ,
                              completion : (()-> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,handler:{
            (_) in
                completion?()
        })
        
        
        alert.addAction(okAction)
        self.present(alert , animated: true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

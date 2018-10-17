//
//  RegisterViewController.swift
//  worldWide
//
//  Created by Abdo on 10/17/18.
//  Copyright © 2018 Abdo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK:- Outlet Action
    
    var waitingForResponse = false
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if waitingForResponse{
            return
        }
        // the same mutex lock
        DispatchQueue.global().sync {
            self.waitingForResponse = true
        }
        Repository.registerNewUser(withEmail: emailTextField.text!, withPassword: passwordTextField.text!, success: { (user) in
            self.presentSimpleMessage(title: "Welcome", message: " A new Account has been created with email \(user.email!)"){ () in 
                self.performSegue(withIdentifier: "loginSegueID", sender: self)
            }
            DispatchQueue.global().sync {
                self.waitingForResponse = false
            }
        }) { (error) in
            self.presentSimpleMessage(title: "Warning", message: error.localizedDescription)
            DispatchQueue.global().sync {
                self.waitingForResponse = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    

}

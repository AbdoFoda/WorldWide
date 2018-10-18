//
//  Repository.swift
//  worldWide
//
//  Created by Abdo on 10/17/18.
//  Copyright © 2018 Abdo. All rights reserved.
//

import Foundation
import Firebase

class UserRepository{
    
    static func registerNewUser(withEmail email : String,
                             withPassword password:String ,
                             success : @escaping (User) -> Void ,
                             failure : @escaping (Error) ->Void) {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let newlyCreatedUser = authResult?.user{
                success(newlyCreatedUser)
            }
            if let e = error{
                failure(e)
            }
        }
    }
    
    static func loginUser(withEmail email : String ,
                          withPassword password:String,
                          success : @escaping (User) -> Void ,
                          failure : @escaping (Error) ->Void){
        Auth.auth().signIn(withEmail: email, password: password) {
            (authResult, error) in
            if let newlyCreatedUser = authResult?.user{
                success(newlyCreatedUser)
            }
            if let e = error{
                failure(e)
            }
        }
    }
    
}

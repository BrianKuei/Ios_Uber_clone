//
//  ViewController.swift
//  Uber Clone
//
//  Created by Teacher on 2019/6/5.
//  Copyright © 2019年 Teacher. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var userModeSwitch: UISwitch!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        if emailAddress.text != "" && passwordTF.text != "" {
            
            authService(email: emailAddress.text!, password: passwordTF.text!)
            
        } else {
            
            print("Please input your email and password!")
        }
    }
    
    
    func displayAlert(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func authService(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            if error != nil {
                
                //print(error)
                //FIRAuthErrorUserInfoNameKey
                let errorString = String(describing: (error as! NSError).userInfo["FIRAuthErrorUserInfoNameKey"]!)
                //print(errorString)
                
                if errorString == "ERROR_USER_NOT_FOUND" {
                    //建立使用者
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            
                            //print(error)
                            self.displayAlert(title: "Create User Account Error", message: (error?.localizedDescription)!)
                            
                        } else {
                            
                            //self.displayAlert(title: "Congradulation!", message: "Create User Account Successfully")
                            
                            if self.userModeSwitch.isOn {
                                //表示為乘客
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                changeRequest?.displayName = "Passenger"
                                changeRequest?.commitChanges(completion: nil)
                                
                                self.performSegue(withIdentifier: "passengerSegue", sender: self)
                                
                            } else{
                                //表示為司機
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                changeRequest?.displayName = "Driver"
                                changeRequest?.commitChanges(completion: nil)
                                
                                self.performSegue(withIdentifier: "driverSegue", sender: self)
                                
                            }
                            
                        }
                    })
                    
                } else {
                    //其他登入錯誤 密碼有誤等
                    self.displayAlert(title: "Sign In Error", message: errorString)
                    
                }

                
            } else {//成功登入系統
                
                //print("User Sign in Successfully")
                
                if auth?.user.displayName == "Passenger" {
                    
                    self.performSegue(withIdentifier: "passengerSegue", sender: self)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "driverSegue", sender: self)
                }
            }
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


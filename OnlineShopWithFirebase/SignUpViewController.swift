//
//  SignUpViewController.swift
//  OnlineShopWithFirebase
//
//  Created by Korlan Omarova on 10.02.2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
       
    }
    func validateFields() -> String?{
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if passwordValidation(cleanedPassword) == false{
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let error = validateFields()
        if error != nil{
            showError(error!)
        } else{
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
                
                if err != nil {
                    self.showError("Error creating user")
                }else{
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": firstName,
                        "lastname": lastName,
                        "uid": authResult!.user.uid
                    ]) { err in
                        if let err = err {
                            self.showError("Error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
                
            }
        }
    }
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    func passwordValidation(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&].{8,}")
        return passwordTest.evaluate(with: password)
    }
   
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }

}

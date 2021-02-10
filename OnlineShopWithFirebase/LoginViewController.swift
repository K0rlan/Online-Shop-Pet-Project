//
//  LoginViewController.swift
//  OnlineShopWithFirebase
//
//  Created by Korlan Omarova on 10.02.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if error != nil{
                strongSelf.errorLabel.text = error!.localizedDescription
                strongSelf.errorLabel.alpha = 1
            }else{
                let homeVC = strongSelf.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
                
                strongSelf.view.window?.rootViewController = homeVC
                strongSelf.view.window?.makeKeyAndVisible()
            }
        }
    }
    

}

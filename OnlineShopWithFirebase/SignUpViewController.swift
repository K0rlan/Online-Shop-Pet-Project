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
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.logo
        return imageView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Online Shop"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = Constants.darkColor
        return label
    }()
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name:"
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.lightDarkColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOpacity = 0.15
        return textField
    }()
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name:"
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.lightDarkColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOpacity = 0.15
        return textField
    }()
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email:"
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.lightDarkColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOpacity = 0.15
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password:"
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Constants.lightDarkColor.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.shadowColor = UIColor.darkGray.cgColor
        textField.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        textField.layer.shadowRadius = 5.0
        textField.layer.shadowOpacity = 0.15
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = Constants.smokieRedColor
        label.alpha = 0
        label.numberOfLines = 0
        return label
    }()
         
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.whiteMirrorColor
        setupViews()
    }
    func validateFields() -> String?{
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{

            return "Please fill in all fields."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if passwordValidation(cleanedPassword) == false{
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }

    @objc func signUpButtonPressed(_ sender: UIButton) {
        let error = validateFields()
        if error != nil{
            showError(error!)
        } else{
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

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
        let homeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
        
        view.window?.rootViewController = homeViewController
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
    private func setupViews(){
        [logoImageView, logoLabel, firstNameTextField, lastNameTextField, loginTextField, passwordTextField, signUpButton, errorLabel].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        firstNameTextField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 50).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        signUpButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.applyGradient(colors: [Constants.tastyRoseColor.cgColor,Constants.smokieRedColor.cgColor])
//        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
        
    }
}

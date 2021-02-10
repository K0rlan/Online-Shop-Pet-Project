//
//  ViewController.swift
//  OnlineShopWithFirebase
//
//  Created by Korlan Omarova on 10.02.2021.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cube")
        return imageView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Online Shop"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = Constants.darkColor
        return label
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
         
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var horizontalLine: SeparatorViews = {
        let view = SeparatorViews()
        return view
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don’t have account? Register now!"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = Constants.lightDarkColor
        return label
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
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
        setupStyleForLine()
    }
    @objc func signUpButtonPressed(_ sender: UIButton){
        print("wef")
//        dismiss(animated: true, completion: nil)
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
//        self.view.window?.rootViewController = signUpViewController
//        self.view.window?.makeKeyAndVisible()
        
//           let ac = SignUpViewController()
//           self.present(ac, animated: true, completion: nil)

    }
    @objc func loginButtonPressed(_ sender: UIButton){
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if error != nil{
                strongSelf.errorLabel.text = error!.localizedDescription
                strongSelf.errorLabel.alpha = 1
            }else{
//                let homeVC = strongSelf.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController
                let homeViewController = HomeViewController()
                strongSelf.navigationController?.pushViewController(homeViewController, animated: true)
                
                strongSelf.view.window?.rootViewController = homeViewController
                strongSelf.view.window?.makeKeyAndVisible()
               
            }
        }
    }
    
    private func setupViews(){
        [logoImageView, logoLabel, loginTextField, passwordTextField, loginButton, horizontalLine, signUpLabel, signUpButton, errorLabel].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        logoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginTextField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 50).isActive = true
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
        errorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.applyGradient(colors: [Constants.tastyRoseColor.cgColor,Constants.smokieRedColor.cgColor])
        
        horizontalLine.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100).isActive = true
        horizontalLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        horizontalLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        horizontalLine.bottomAnchor.constraint(equalTo: setUpLabel.topAnchor, constant: 10).isActive = true
        
        signUpLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 10).isActive = true
        signUpLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        signUpLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
//        setUpLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: 10).isActive = true

        signUpButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.applyGradient(colors: [Constants.tastyRoseColor.cgColor,Constants.smokieRedColor.cgColor])
//        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
        
    }
    
    private func setupStyleForLine(){
        horizontalLine.layer.borderWidth = 1.0
        horizontalLine.layer.borderColor = Constants.lightDarkColor.cgColor
        
    }
    


}



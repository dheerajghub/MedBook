//
//  LoginViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: PROPERTIES -
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.tapFeedBack()
        button.backgroundColor = .black
        button.layer.cornerRadius = 17.5
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome,\nLogin to continue"
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let emailTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.textColor = .black
        textField.tintColor = .black
        return textField
    }()
    
    
    let passwordTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.textColor = .black
        textField.tintColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        
        view.addSubview(emailTextCoverView)
        emailTextCoverView.addSubview(emailTextField)
        
        view.addSubview(passwordTextCoverView)
        passwordTextCoverView.addSubview(passwordTextField)
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            headerLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextCoverView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            emailTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextCoverView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextCoverView.trailingAnchor, constant: -15),
            emailTextField.centerYAnchor.constraint(equalTo: emailTextCoverView.centerYAnchor),
            
            
            passwordTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextCoverView.topAnchor.constraint(equalTo: emailTextCoverView.bottomAnchor, constant: 15),
            passwordTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextCoverView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextCoverView.trailingAnchor, constant: -15),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordTextCoverView.centerYAnchor)
        ])
    }
    
    // MARK: ACTIONS -
    
    @objc func backButtonTapped(){
        self.dismiss(animated: true)
    }

}

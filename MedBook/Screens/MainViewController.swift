//
//  MainViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit
import KeychainSwift

class MainViewController: UIViewController {

    // MARK: PROPERTIES -
    
    let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "book.circle.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    let appLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MedBook"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .black)
        return label
    }()
    
    let actionstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.tapFeedBack()
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.tapFeedBack()
        return button
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        
        let keychain = KeychainSwift()
        print(keychain.allKeys)
        
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(appLogoImageView)
        view.addSubview(appLabel)
        
        view.addSubview(actionstackView)
        actionstackView.addArrangedSubview(signupButton)
        actionstackView.addArrangedSubview(loginButton)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            appLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 120),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 120),
            appLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            appLabel.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            actionstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            actionstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            actionstackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionstackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - ACTIONS
    
    @objc func loginButtonTapped(){
        
        let controller = LoginViewController()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    
    @objc func signupButtonTapped(){
        
        let controller = SignupViewController()
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }


}

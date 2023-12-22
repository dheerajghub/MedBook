//
//  HomeViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

class HomeViewController: UIViewController {

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
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Which topic interests\nyou today?"
        label.textAlignment = .center
        label.textColor = .darkGray.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var customSearchView: CustomSearchBarView = {
        let searchView = CustomSearchBarView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.forSearching = false
        searchView.actionButton.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        
        
        searchView.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search for books",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        
        searchView.searchCoverView.layer.borderColor = UIColor.black.cgColor
        
        return searchView
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .lightGray.withAlphaComponent(0.1)
        button.tapFeedBack()
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(appLogoImageView)
        view.addSubview(appLabel)
        view.addSubview(headerLabel)
        view.addSubview(customSearchView)
        view.addSubview(logoutButton)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 120),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 120),
            appLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            appLabel.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 10),
            appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 30),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            customSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            customSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            customSearchView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            customSearchView.heightAnchor.constraint(equalToConstant: 45),
            
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    // MARK: - ACTIONS
    
    @objc func goToSearch(){
        let controller = SearchViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }
    
    @objc func logoutButtonTapped(){
        showAlert("Alert", message: "Are you sure want to logout!", actionButtonName: "Logout", isDestructive: true) { success in
            if success {
                AuthViewModel().logoutUser()
                let controller = MainViewController()
                controller.modalTransitionStyle = .crossDissolve
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }

}

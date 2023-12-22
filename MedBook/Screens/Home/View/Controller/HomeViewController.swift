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
        return searchView
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
            
            customSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            customSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            customSearchView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            customSearchView.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK: - ACTIONS
    
    @objc func goToSearch(){
        let controller = SearchViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }

}

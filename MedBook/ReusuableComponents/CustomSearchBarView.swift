//
//  CustomSearchBarView.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

class CustomSearchBarView: UIView {

    // MARK: PROPERTIES -
    
    var forSearching: Bool = false {
        didSet {
            actionButton.isHidden = forSearching ? true : false
        }
    }
    
    let searchCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 22.5
        return view
    }()
    
    let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .darkGray.withAlphaComponent(0.7)
        return imageView
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = ""
        textField.tintColor = .black
        textField.textColor = .black
        return textField
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.isHidden = true
        button.tapFeedBack()
        return button
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        addSubview(searchCoverView)
        searchCoverView.addSubview(searchIcon)
        searchCoverView.addSubview(searchTextField)
        searchCoverView.addSubview(closeButton)
        
        addSubview(actionButton)
    }
    
    func setUpConstraints(){
        searchCoverView.pin(to: self)
        actionButton.pin(to: self)
        NSLayoutConstraint.activate([
            searchIcon.leadingAnchor.constraint(equalTo: searchCoverView.leadingAnchor, constant: 10),
            searchIcon.widthAnchor.constraint(equalToConstant: 25),
            searchIcon.heightAnchor.constraint(equalToConstant: 25),
            searchIcon.centerYAnchor.constraint(equalTo: searchCoverView.centerYAnchor),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -5),
            searchTextField.centerYAnchor.constraint(equalTo: searchCoverView.centerYAnchor),
            
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.centerYAnchor.constraint(equalTo: searchCoverView.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: searchCoverView.trailingAnchor, constant: -5)
        ])
    }

}

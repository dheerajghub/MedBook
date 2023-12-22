//
//  ValidationCheckPointView.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit

class ValidationCheckPointView: UIView {
    
    // MARK: PROPERTIES -
    
    let checkBoxImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "square")
        image.tintColor = .lightGray.withAlphaComponent(0.5)
        return image
    }()
    
    let validationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
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
        addSubview(checkBoxImage)
        addSubview(validationLabel)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            checkBoxImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBoxImage.widthAnchor.constraint(equalToConstant: 25),
            checkBoxImage.heightAnchor.constraint(equalToConstant: 25),
            checkBoxImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            validationLabel.leadingAnchor.constraint(equalTo: checkBoxImage.trailingAnchor, constant: 15),
            validationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            validationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func validated(_ isValidated: Bool){
        if isValidated {
            checkBoxImage.image = UIImage(systemName: "checkmark.square.fill")
            checkBoxImage.tintColor = .black
            self.setStrikeThrough(value: 1)
        } else {
            checkBoxImage.image = UIImage(systemName: "square")
            checkBoxImage.tintColor = .lightGray.withAlphaComponent(0.5)
            self.setStrikeThrough(value: 0)
        }
    }
    
    func setStrikeThrough(value: Int){
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: validationLabel.text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: value, range: NSRange(location: 0, length: attributeString.length))
        validationLabel.attributedText = attributeString
    }
    
}

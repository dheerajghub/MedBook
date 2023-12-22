//
//  CustomFilterView.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit

enum FilterTypes: Int {
    case title = 1
    case average
    case hits
}

protocol FilterActionDelegate {
    func didFilterButtonTapped(forfilterType: FilterTypes?)
}

class CustomFilterView: UIView {
    
    // MARK: PROPERTIES -
    
    var delegate: FilterActionDelegate?
    
    let sortedByLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sort By:"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        return stackView
    }()
    
    lazy var titleFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Title", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17.5
        button.tag = 1
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tapFeedBack()
        return button
    }()
    
    lazy var averageFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Average", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17.5
        button.tag = 2
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tapFeedBack()
        return button
    }()
    
    lazy var hitsFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hits", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 17.5
        button.tag = 3
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.tapFeedBack()
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
        backgroundColor = .white
        addSubview(sortedByLabel)
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleFilterButton)
        stackView.addArrangedSubview(averageFilterButton)
        stackView.addArrangedSubview(hitsFilterButton)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            sortedByLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sortedByLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortedByLabel.widthAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: sortedByLabel.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func updateForUI(filterType: FilterTypes){
        
        switch filterType {
        case .title:
            
            titleFilterButton.backgroundColor = .black
            titleFilterButton.setTitleColor(.white, for: .normal)
            titleFilterButton.layer.borderWidth = 0
            
            averageFilterButton.backgroundColor = .clear
            averageFilterButton.setTitleColor(.black, for: .normal)
            averageFilterButton.layer.borderWidth = 1
            
            hitsFilterButton.backgroundColor = .clear
            hitsFilterButton.setTitleColor(.black, for: .normal)
            hitsFilterButton.layer.borderWidth = 1
            
        case .average:
            
            averageFilterButton.backgroundColor = .black
            averageFilterButton.setTitleColor(.white, for: .normal)
            averageFilterButton.layer.borderWidth = 0
            
            titleFilterButton.backgroundColor = .clear
            titleFilterButton.setTitleColor(.black, for: .normal)
            titleFilterButton.layer.borderWidth = 1
            
            hitsFilterButton.backgroundColor = .clear
            hitsFilterButton.setTitleColor(.black, for: .normal)
            hitsFilterButton.layer.borderWidth = 1
            
        case .hits:
            
            hitsFilterButton.backgroundColor = .black
            hitsFilterButton.setTitleColor(.white, for: .normal)
            hitsFilterButton.layer.borderWidth = 0
            
            averageFilterButton.backgroundColor = .clear
            averageFilterButton.setTitleColor(.black, for: .normal)
            averageFilterButton.layer.borderWidth = 1
            
            titleFilterButton.backgroundColor = .clear
            titleFilterButton.setTitleColor(.black, for: .normal)
            titleFilterButton.layer.borderWidth = 1
            
        }
        
    }
    
    // MARK: - ACTIONS
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        let filterType = FilterTypes(rawValue: sender.tag)
        delegate?.didFilterButtonTapped(forfilterType: filterType ?? nil)
    }
    
}

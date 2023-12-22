//
//  BookItemCard.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit
import Kingfisher

class BookItemCard: UITableViewCell {
    
    // MARK: PROPERTIES -
    
    var bookData: BookDocModel? {
        didSet {
            manageData()
        }
    }
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let bookDefaultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    let defaultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "book.pages")
        imageView.tintColor = .darkGray.withAlphaComponent(0.6)
        return imageView
    }()
    
    let bookCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let ratingAverageLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("--", for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = UIColor(hexString: "#FF9529")
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let ratingCountLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("--", for: .normal)
        button.setImage(UIImage(systemName: "aspectratio.fill"), for: .normal)
        button.tintColor = .lightGray
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    // MARK: MAIN -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        backgroundColor = .clear
        addSubview(cardView)
        
        cardView.addSubview(bookDefaultView)
        bookDefaultView.addSubview(defaultImage)
        
        cardView.addSubview(bookCoverImage)
        cardView.addSubview(bookTitleLabel)
        cardView.addSubview(bookAuthorLabel)
        
        cardView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(ratingAverageLabel)
        infoStackView.addArrangedSubview(ratingCountLabel)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            bookCoverImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            bookCoverImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            bookCoverImage.widthAnchor.constraint(equalToConstant: 60),
            bookCoverImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            bookDefaultView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            bookDefaultView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            bookDefaultView.widthAnchor.constraint(equalToConstant: 60),
            bookDefaultView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            defaultImage.centerXAnchor.constraint(equalTo: bookDefaultView.centerXAnchor),
            defaultImage.centerYAnchor.constraint(equalTo: bookDefaultView.centerYAnchor),
            defaultImage.widthAnchor.constraint(equalToConstant: 40),
            defaultImage.heightAnchor.constraint(equalToConstant: 40),
            
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookCoverImage.trailingAnchor, constant: 15),
            bookTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            bookTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            bookAuthorLabel.leadingAnchor.constraint(equalTo: bookCoverImage.trailingAnchor, constant: 15),
            bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 3),
            
            infoStackView.leadingAnchor.constraint(equalTo: bookCoverImage.trailingAnchor, constant: 15),
            infoStackView.topAnchor.constraint(equalTo: bookAuthorLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func manageData(){
        
        guard let bookData else { return }
        
        let bookTitle = bookData.title ?? ""
        let bookAuthors = bookData.authorName ?? []
        let coverId = bookData.coverId ?? 0
        let ratingsAverage = bookData.ratingsAverage ?? 0
        let ratingsCount = bookData.ratingsCount ?? 0
        
        var bookAuthorsText = ""
        
        bookTitleLabel.text = bookTitle
        
        for i in 0..<bookAuthors.count {
            let authorName = bookAuthors[i]
            bookAuthorsText += authorName + ","
        }
        
        
        if bookAuthorsText.count > 0 {
            bookAuthorsText.removeLast()
        }

        bookAuthorLabel.text = bookAuthorsText
        
        let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")
        bookCoverImage.kf.setImage(with: url)
        
        ratingAverageLabel.setTitle(" \(ratingsAverage.custom)", for: .normal)
        ratingCountLabel.setTitle(" \(ratingsCount)", for: .normal)
        
    }

}

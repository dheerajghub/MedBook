//
//  SearchViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: PROPERTIES -
    
    // Header View
    
    let viewModel = BookSearchViewModel()
    
    var bottomContentConstraints: NSLayoutConstraint?
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var customSearchView: CustomSearchBarView = {
        let searchView = CustomSearchBarView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.forSearching = true
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchView.closeButton.addTarget(self, action: #selector(clearTextFieldButtonTapped), for: .touchUpInside)
        return searchView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        button.backgroundColor = .lightGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 22.5
        button.tapFeedBack()
        return button
    }()
    
    lazy var filterView: CustomFilterView = {
        let filterView = CustomFilterView()
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.delegate = self
        return filterView
    }()
    
    //:
    
    // Content View
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var searchItemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookItemCard.self, forCellReuseIdentifier: "BookItemCard")
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let loaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    
    //:
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        bottomContentConstraints = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomContentConstraints!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // making textfield first responder
        customSearchView.searchTextField.becomeFirstResponder()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.addSubview(customSearchView)
        headerView.addSubview(cancelButton)
        
        view.addSubview(filterView)
        
        view.addSubview(contentView)
        contentView.addSubview(searchItemsTableView)
        
        
        view.addSubview(loaderView)
        loaderView.addSubview(activityIndicator)
    }
    
    func setUpConstraints(){
        searchItemsTableView.pin(to: contentView)
        loaderView.pin(to: contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            customSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            customSearchView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -10),
            customSearchView.heightAnchor.constraint(equalToConstant: 45),
            customSearchView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func loadSearchResults(searchText: String){
        
        loaderView.isHidden = false
        viewModel.searchTimer?.invalidate()
        
        // if not for pagination clear the search item array
        if viewModel.offset == 0 {
            viewModel.searchedItems.removeAll()
        }
        
        // adding debouncing for smooth quering
        viewModel.searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                
                guard let self else { return }
                
                // Use search text and perform the query
                viewModel.searchForBook(with: searchText) { success, error in
                    self.loaderView.isHidden = true
                    self.searchItemsTableView.reloadData()
                }
                
            }
        })
        
    }
    
    // MARK: - ACTIONS
    
    @objc func dismissController(){
        dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        viewModel.offset = 0
        
        let enteredText = textField.text ?? ""
        
        if textField.text == "" {
            // on empty text
            customSearchView.closeButton.isHidden = true
        } else {
            customSearchView.closeButton.isHidden = false
        }
        
        if enteredText.count >= 3 {
            self.loadSearchResults(searchText: enteredText)
        }
        
    }
    
    @objc func clearTextFieldButtonTapped(){
        customSearchView.searchTextField.text = ""
        customSearchView.closeButton.isHidden = true
        viewModel.searchedItems.removeAll()
        searchItemsTableView.reloadData()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomContentConstraints?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            }
            
        }
    }

}


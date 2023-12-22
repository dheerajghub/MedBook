//
//  SearchViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {

    // MARK: PROPERTIES -
    
    let viewModel = BookSearchViewModel()
    
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
        return button
    }()
    
    lazy var searchItemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.
        return tableView
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
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
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            customSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            customSearchView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -10),
            customSearchView.heightAnchor.constraint(equalToConstant: 45),
            customSearchView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    func loadSearchResults(searchQuery: String){
        
        viewModel.searchTimer?.invalidate()
        
        // if not for pagination clear the search item array
        viewModel.searchedItems.removeAll()
        
        viewModel.searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                
                guard let self else { return }
                
                //Use search text and perform the query
                viewModel.searchForBook(with: searchQuery) { success, error in
                    print(self.viewModel.searchedItems)
                }
                
            }
        })
        
    }
    
    // MARK: - ACTIONS
    
    @objc func dismissController(){
        dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        let enteredText = textField.text ?? ""
        
        if textField.text == "" {
            // on empty text
            customSearchView.closeButton.isHidden = true
        } else {
            customSearchView.closeButton.isHidden = false
        }
        
        if enteredText.count >= 3 {
            self.loadSearchResults(searchQuery: enteredText)
        }
        
    }
    
    @objc func clearTextFieldButtonTapped(){
        customSearchView.searchTextField.text = ""
        customSearchView.closeButton.isHidden = true
    }

}

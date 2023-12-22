//
//  SearchViewController+Delegate.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookItemCard", for: indexPath) as! BookItemCard
        if viewModel.searchedItems.count > 0 {
            cell.bookData = viewModel.searchedItems[indexPath.row]
        }
        cell.selectionStyle = .none
        
        // pagination logic
        if indexPath.row == viewModel.searchedItems.count - 1 { // last cell
            if viewModel.searchedItems.count < viewModel.totalSearchedItemCount  {
                self.loadSearchResults(searchText: customSearchView.searchTextField.text ?? "")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

//
//  SearchViewController+ActionDelegate.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import Foundation

extension SearchViewController: FilterActionDelegate {
    
    func didFilterButtonTapped(forfilterType: FilterTypes?) {
        
        guard let forfilterType else { return }
        
        filterView.updateForUI(filterType: forfilterType)
        viewModel.currentSelectedFilter = forfilterType
        viewModel.sortItemsByFilter(forfilterType) {
            self.searchItemsTableView.reloadData()
        }
        
    }
    
}

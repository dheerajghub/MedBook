//
//  BookSearchViewModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import Foundation

class BookSearchViewModel {
    
    let httpUtility = HttpUtility()
    var limit = 10
    var offset = 0
    var searchedItems: [BookDocModel] = []
    var totalSearchedItemCount = 0
    var searchTimer: Timer?
    
    var currentSelectedFilter: FilterTypes?
    
    func searchForBook(with queryString: String, _ completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        let urlString = "https://openlibrary.org/search.json?title=\(queryString)&limit=\(limit)&offset=\(offset)"
        
        httpUtility.getApiData(urlString: urlString, resultType: BookSearchModel.self) { result, error in
            
            if error == nil {
                
                guard let result, let items = result.docs, let totalItemsCount = result.numFound else { return }
                
                self.totalSearchedItemCount = totalItemsCount
                
                if self.searchedItems.isEmpty {
                    self.searchedItems = items
                } else {
                    self.searchedItems.append(contentsOf: items)
                }
                
                if self.searchedItems.count.isMultiple(of: self.limit) {
                    self.offset += self.limit
                }
                
                self.sortItemsByFilter(self.currentSelectedFilter) {
                    DispatchQueue.main.async {
                        completion(true, nil)
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
            }
            
        }
        
    }
    
    func sortItemsByFilter(_ filter: FilterTypes?, _ completion: @escaping() -> ()) {
        
        guard let filter else {
            completion()
            return
        }
        
        switch filter {
        case .title:
            self.searchedItems = searchedItems.sorted { bookA, bookB in
                bookA.title ?? "" > bookB.title ?? ""
            }
            completion()
        case .average:
            self.searchedItems = searchedItems.sorted { bookA, bookB in
                bookA.ratingsAverage ?? 0 > bookB.ratingsAverage ?? 0
            }
            completion()
        case .hits:
            self.searchedItems = searchedItems.sorted { bookA, bookB in
                bookA.ratingsCount ?? 0 > bookB.ratingsCount ?? 0
            }
            completion()
        }
    }
    
}

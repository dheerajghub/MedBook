//
//  HttpUtility.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import Foundation

public struct HttpUtility {
    
    func getApiData<T: Codable>(urlString: String, resultType: T.Type, completionHandler: @escaping(_ result: T?, _ error: String?) -> Void){
        
        guard let requestURL = URL(string: urlString) else {
            completionHandler(nil, "invalid URL!")
            return
        }
        
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "get"
        
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            if (error == nil && responseData != nil && responseData?.count != 0){
                
                // parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completionHandler(result, nil)
                }
                catch let error {
                    let error = "error occur while decoding = \(error.localizedDescription)"
                    completionHandler(nil, error)
                }
                
            } else {
                let response = httpUrlResponse as? HTTPURLResponse
                let responseCode = response?.statusCode ?? 0
                let error = "\(responseCode) : Error"
                completionHandler(nil, error)
            }
        }.resume()
        
    }
    
}


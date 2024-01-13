//
//  AuthViewModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import Foundation
import KeychainSwift
import RealmSwift


class AuthViewModel {
    
    let httpUtility = HttpUtility()
    let keychain = KeychainSwift()
    let realm = try! Realm()
    var countries: [String] = []
    
    let isLoggedIn = "isLoggedIn"
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var currentCountry: String = ""
    
    var showPassword = false
    
    var validationOne = false
    var validationTwo = false
    var validationThree = false
    
    func signupNewUser(_ completion: @escaping (Bool, String?) -> Void){
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !currentCountry.isEmpty else {
            DispatchQueue.main.async {
                completion(false, "Missing Details!")
            }
            return
        }
        
        // check whether user with same email exist if so, return message
        if isUserAlreadyExist(withEmail: email) {
            DispatchQueue.main.async {
                completion(false, "User already exist with this email \(self.email)")
            }
            return
        }
        
        let user = UserRealmModel(name: name, email: email, currentCountry: currentCountry, password: password)
        
        do {
            try! realm.write {
                realm.add(user)
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                DispatchQueue.main.async {
                    completion(true, "Sign up successfully!")
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(false, "Unable to create user account!")
            }
            return
        }
        
    }
    
    
    func loginUser(_ completion: @escaping (Bool, String?) -> Void){
        
        guard !email.isEmpty, !password.isEmpty else {
            DispatchQueue.main.async {
                completion(false, "Missing Details!")
            }
            return
        }
        
        let users = realm.objects(UserRealmModel.self)
        
        let user = users.where { user in
            return user.email == email.lowercased() && user.password == password
        }
        
        if user.count > 0 {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            DispatchQueue.main.async {
                completion(true, "Logged In Successfully!")
            }
        } else {
            DispatchQueue.main.async {
                completion(false, "Email or Password Invalid!")
            }
        }
        
    }
    
    func logoutUser(){
        UserDefaults.standard.set(false, forKey: isLoggedIn)
    }
    
    func logoutAndDeleteUser(){
        UserDefaults.standard.set(false, forKey: isLoggedIn)
    }
    
    func getCountryList(_ completion: @escaping (Bool, String?)-> Void){
        
        let urlString = "https://api.first.org/data/v1/countries"
        
        httpUtility.getApiData(urlString: urlString, resultType: CountryListModel.self) { result, error in
            if error == nil {
                guard let result, let countryData = result.data else { return }
                self.getCountries(data: countryData)
                self.sortCountriesAlphabetically()
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, "Error")
                }
            }
        }
    }
    
    func getDefaultCountry(_ completion: @escaping (Bool, String?)-> Void){
        
        let urlString = "http://ip-api.com/json"
        
        httpUtility.getApiData(urlString: urlString, resultType: MyIPModel.self) { result, error in
            if error == nil {
                guard let result, let myCountry = result.country else { return }
                self.currentCountry = myCountry
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, "Error")
                }
            }
        }
        
    }
    
    func getCountries(data: [String: CountryData]?){
        guard let data else { return }
        for (_,value) in data {
            let countryName = value.country ?? ""
            countries.append(countryName)
        }
    }
    
    func getCountryIndex() -> Int? {
        let index = countries.firstIndex {
            $0 == currentCountry
        }
        return index ?? 0
    }
    
    func sortCountriesAlphabetically(){
        self.countries = countries.sorted { countryA, countryB in
            countryA < countryB
        }
    }
    
    // MARK: - REALM FUNCTIONS
    
    func isUserAlreadyExist(withEmail: String) -> Bool {
        
        let users = realm.objects(UserRealmModel.self)
        
        let user = users.where {
            $0.email == withEmail
        }
        
        return user.count > 0 ? true : false
        
    }
    
}

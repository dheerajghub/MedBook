//
//  AuthViewModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import Foundation
import KeychainSwift


class AuthViewModel {
    
    let httpUtility = HttpUtility()
    let keychain = KeychainSwift()
    var countries: [String] = []
    
    var email: String = ""
    var password: String = ""
    var currentCountry: String = ""
    
    var showPassword = false

    var LoggedInUserDataInKeychain = "loggedInUserData"
    var isLoggedIn = "isUserLoggedIn"
    
    var validationOne = false
    var validationTwo = false
    var validationThree = false
    
    func signupNewUser(_ completion: (Bool, String?) -> Void){
        
        guard !email.isEmpty, !password.isEmpty, !currentCountry.isEmpty else {
            completion(false, "Missing Details!")
            return
        }
        
        let userModel = UserModel(email: self.email, password: self.password, countryName: self.currentCountry)
        
        do {
            let userObjectData = try JSONEncoder().encode(userModel)
            keychain.set(userObjectData, forKey: LoggedInUserDataInKeychain)
            completion(true, "Signup successfully!")
            
            UserDefaults.standard.set(true, forKey: isLoggedIn)
            
        } catch {
            completion(false, "Unable to create user account!")
            return
        }
        
    }
    
    
    func loginUser(_ completion: (Bool, String?) -> Void){
        
        guard !email.isEmpty, !password.isEmpty else {
            completion(false, "Missing Details!")
            return
        }
        
        guard let userObjectData = keychain.getData(LoggedInUserDataInKeychain) else {
            completion(false, "email or password invalid!")
            return
        }
        
        do {
            
            let userData = try JSONDecoder().decode(UserModel.self, from: userObjectData)
            
            if self.email == userData.email ?? "" && self.password == userData.password {
                completion(true, "LoggedIn successfully!")
                UserDefaults.standard.set(true, forKey: isLoggedIn)
            } else {
                completion(false, "email or password invalid!")
            }
            
        } catch {
            completion(false, "Unable to create user account!")
            return
        }
        
        
    }
    
    func logoutUser(){
        UserDefaults.standard.set(false, forKey: isLoggedIn)
    }
    
    func logoutAndDeleteUser(){
        keychain.delete(LoggedInUserDataInKeychain)
        keychain.clear()
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
    
}

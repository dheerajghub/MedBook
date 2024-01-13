//
//  SignupViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: PROPERTIES -
    
    let viewModel = AuthViewModel()
    
    lazy var countryPicker: UIPickerView = {
        let countryPicker = UIPickerView()
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.setValue(UIColor.black, forKey: "textColor")
        return countryPicker
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.tapFeedBack()
        button.backgroundColor = .black
        button.layer.cornerRadius = 17.5
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome,\nSignup to continue"
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let nameTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        
        textField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    
    let emailTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        
        textField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    
    let passwordTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.textColor = .black
        textField.tintColor = .black
        textField.isSecureTextEntry = true
        
        textField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tapFeedBack()
        button.tintColor = .black
        button.addTarget(self, action: #selector(showPasswordButton), for: .touchUpInside)
        return button
    }()
    
    
    // Validation point stack view
    
    let validatePointStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let validationOne: ValidationCheckPointView = {
        let view = ValidationCheckPointView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.validationLabel.text = "At least 8 characters"
        return view
    }()
    
    let validationTwo: ValidationCheckPointView = {
        let view = ValidationCheckPointView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.validationLabel.text = "Must contain uppercase letter"
        return view
    }()
    
    let validationThree: ValidationCheckPointView = {
        let view = ValidationCheckPointView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.validationLabel.text = "Contains special charater"
        return view
    }()
    
    //:
    
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.tapFeedBack()
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
        
        let group = DispatchGroup()
        group.enter()
        viewModel.getCountryList { success, error in
            if success {
                self.countryPicker.reloadAllComponents()
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.viewModel.getDefaultCountry { success, error in
                if success {
                    let index = self.viewModel.getCountryIndex() ?? 0
                    self.countryPicker.selectRow(index, inComponent: 0, animated: true)
                }
            }
        }
        
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        
        view.addSubview(nameTextCoverView)
        nameTextCoverView.addSubview(nameTextField)
        
        view.addSubview(emailTextCoverView)
        emailTextCoverView.addSubview(emailTextField)
        
        view.addSubview(passwordTextCoverView)
        passwordTextCoverView.addSubview(passwordTextField)
        passwordTextCoverView.addSubview(showButton)
        
        view.addSubview(validatePointStackView)
        validatePointStackView.addArrangedSubview(validationOne)
        validatePointStackView.addArrangedSubview(validationTwo)
        validatePointStackView.addArrangedSubview(validationThree)
        
        view.addSubview(countryPicker)
        view.addSubview(signupButton)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            headerLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextCoverView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            nameTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameTextCoverView.leadingAnchor, constant: 15),
            nameTextField.trailingAnchor.constraint(equalTo: nameTextCoverView.trailingAnchor, constant: -15),
            nameTextField.centerYAnchor.constraint(equalTo: nameTextCoverView.centerYAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextCoverView.topAnchor.constraint(equalTo: nameTextCoverView.bottomAnchor, constant: 15),
            emailTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextCoverView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextCoverView.trailingAnchor, constant: -15),
            emailTextField.centerYAnchor.constraint(equalTo: emailTextCoverView.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextCoverView.topAnchor.constraint(equalTo: emailTextCoverView.bottomAnchor, constant: 15),
            passwordTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextCoverView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: showButton.leadingAnchor, constant: -5),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordTextCoverView.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            showButton.trailingAnchor.constraint(equalTo: passwordTextCoverView.trailingAnchor, constant: -15),
            showButton.centerYAnchor.constraint(equalTo: passwordTextCoverView.centerYAnchor),
            showButton.widthAnchor.constraint(equalToConstant: 40),
            showButton.heightAnchor.constraint(equalToConstant: 40),
            
            validatePointStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            validatePointStackView.topAnchor.constraint(equalTo: passwordTextCoverView.bottomAnchor, constant: 20),
            validatePointStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            validationOne.heightAnchor.constraint(equalToConstant: 40),
            validationTwo.heightAnchor.constraint(equalToConstant: 40),
            validationThree.heightAnchor.constraint(equalToConstant: 40),
            
            countryPicker.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -10),
            countryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryPicker.heightAnchor.constraint(equalToConstant: 140),
            
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            signupButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func actionButtonUpdates() {
        
        if viewModel.validationOne && viewModel.validationTwo && viewModel.validationThree && !viewModel.email.isEmpty && !viewModel.name.isEmpty {
            signupButton.isEnabled = true
            signupButton.alpha = 1
        } else {
            signupButton.isEnabled = false
            signupButton.alpha = 0.5
        }
        
    }
    
    // MARK: ACTIONS -
    
    @objc func backButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func signupButtonTapped(){
        
        viewModel.signupNewUser { success, message in
            if success {
                self.showAlert("Success", message: message ?? "", actionButtonName: "Let's go") { _ in
                    // redirect user to listing page
                    let controller = HomeViewController()
                    controller.modalTransitionStyle = .crossDissolve
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            } else {
                self.showAlert("Error", message: message ?? "") { _ in }
            }
        }
        
    }
    
    @objc func showPasswordButton(){
        viewModel.showPassword = !viewModel.showPassword
        
        if viewModel.showPassword {
            showButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            showButton.tintColor = .black
            passwordTextField.isSecureTextEntry = false
        } else {
            showButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            showButton.tintColor = .black
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func nameTextFieldDidChange(_ textField: UITextField) {
        
        let enteredText = textField.text ?? ""
        viewModel.name = enteredText
        actionButtonUpdates()
        
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        
        let enteredText = textField.text ?? ""
        viewModel.email = enteredText
        actionButtonUpdates()
        
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        
        let enteredText = textField.text ?? ""
        
        
        // At least 8 characters
        if enteredText.count > 8 {
            validationOne.validated(true)
            viewModel.validationOne = true
        } else {
            validationOne.validated(false)
            viewModel.validationOne = false
        }
        
        // Must contain an uppercase letter
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let enteredTextTest1 = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = enteredTextTest1.evaluate(with: enteredText)
        if capitalresult {
            validationTwo.validated(true)
            viewModel.validationTwo = true
        } else {
            validationTwo.validated(false)
            viewModel.validationTwo = false
        }
        
        // Contains a special character
        let specialCharaterRegEx  = ".*[!&^%$#@()/]+.*"
        let enteredTextTest2 = NSPredicate(format:"SELF MATCHES %@", specialCharaterRegEx)
        let specialCharResult = enteredTextTest2.evaluate(with: enteredText)
        if specialCharResult {
            validationThree.validated(true)
            viewModel.validationThree = true
        } else {
            validationThree.validated(false)
            viewModel.validationThree = false
        }
        
        viewModel.password = enteredText
        actionButtonUpdates()
        
    }

}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return viewModel.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        viewModel.currentCountry = viewModel.countries[row]
    }
    
}

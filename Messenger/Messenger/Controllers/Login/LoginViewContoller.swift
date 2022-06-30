//
//  LoginViewContoller.swift
//  Messenger
//
//  Created by viktor on 16.06.2022.
//

import UIKit

class LoginViewContoller: UIViewController {
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView ()
        scrollView.clipsToBounds = true
        return scrollView
    } ()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleToFill
        return imageView
    } ()
    
    private let emailField: UITextField = {
        let field = UITextField ()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Введите имейл"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    } ()

    private let passwordField: UITextField = {
        let field = UITextField ()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Введите пароль"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    } ()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зайти", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Log in"
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width/3
        imageView.frame = CGRect(x: (scrollView.width-size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10 ,
                                  width: scrollView.width - 60,
                                 height: 52)
        passwordField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 80,
                                  width: scrollView.width - 60,
                                 height: 52)
        
       loginButton.frame = CGRect(x: 30,
                                                 y: imageView.bottom + 150,
                                                 width: scrollView.width - 60,
                                                height: 52)
    }
    @objc private func loginButtonTapped () {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError ()
            return
        }
        //firebase login
    }
    
    func alertUserLoginError () {
        let alert = UIAlertController(title: "Опс", message: "Пожайлуста введите всю информацию", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Убрать", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
   @objc private func didTapRegister() {
        let vc = RegisterViewController ()
       vc.title = "Create Account"
       navigationController?.pushViewController(vc, animated: true)
    }

}


extension LoginViewContoller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}

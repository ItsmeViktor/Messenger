//
//  RegisterViewController.swift
//  Messenger
//
//  Created by viktor on 16.06.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView ()
        scrollView.clipsToBounds = true
        return scrollView
    } ()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
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
    
    
    private let firstNameField: UITextField = {
        let field = UITextField ()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Введите имя"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    } ()
    
    
    private let lastNameField: UITextField = {
        let field = UITextField ()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Введите фамилию"
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
    

    
    private let RegisterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегестрироваться", for: .normal)
        button.backgroundColor = .systemRed
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
        RegisterButton.addTarget(self,
                              action: #selector(RegisterButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(RegisterButton)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapChangePick))
     
        
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didtapChangePick () {
       presentPhotoActionSheet()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = view.width/3
        imageView.frame = CGRect(x: (scrollView.width-size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10 ,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: imageView.bottom + 80,
                                     width: scrollView.width - 60,
                                     height: 52)
       
        firstNameField.frame = CGRect(x: 30,
                                   y: imageView.bottom + 150,
                                   width: scrollView.width - 60,
                                   height: 52)
        lastNameField.frame = CGRect(x: 30,
                                   y: imageView.bottom + 210,
                                   width: scrollView.width - 60,
                                   height: 52)
        RegisterButton.frame = CGRect(x: 30,
                                   y: imageView.bottom + 280,
                                   width: scrollView.width - 60,
                                   height: 52)
        
    }
    @objc private func RegisterButtonTapped () {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
                !password.isEmpty,
              !firstName.isEmpty,
                !lastName.isEmpty,
              password.count >= 6 else {
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


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            RegisterButtonTapped()
        }
        return true
    }
}


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentPhotoActionSheet () {
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to select a picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "take photo",
                                            style: .default,
                                            handler: { [weak self ]_ in
            self?.presentCamera ()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "chose photo",
                                            style: .default,
                                            handler: { [weak self ]_ in
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    
    func presentCamera () {
        let vc = UIImagePickerController ()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController ()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
       self.imageView.image = selectedImage
         
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

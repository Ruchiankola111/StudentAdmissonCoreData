//
//  SecondController.swift
//  NewNotes10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewStudent: UIViewController {
    
    var student:Student?
    
    let temp = CoreDataHandler.shared
    
    public let passTextField1:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.isSecureTextEntry = true
        return textField
    }()
    public let nameTextField2:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let divTextField3:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter class"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let phoneTextField4:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter phone number"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let emailTextField5:UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter email number"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    private let MyButton:UIButton={
        let button=UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(OnInsertButtonClick), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    private let BackButton:UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(classTapped), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.cornerRadius = 5
        return button
    }()
    @objc private func classTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func OnInsertButtonClick()
    {
        let password = passTextField1.text!
        let name = nameTextField2.text!
        let div = divTextField3.text!
        let phone = phoneTextField4.text!
        let email = emailTextField5.text!
        
        if let std = student {
            CoreDataHandler.shared.update(std: std, password: password, name: name, div: div, phone: phone, email: email) {
                 print("data update")
                self.resetFields()
            }
           
            
        }else {
            CoreDataHandler.shared.insert(password: password, name: name, div: div, phone: phone, email: email) {
                print("data insert")
                self.resetFields()
            }
        }
         navigationController?.popViewController(animated: true)
    }

    
    private func resetFields() {
        student = nil
        passTextField1.text = ""
        nameTextField2.text = ""
        divTextField3.text = ""
        phoneTextField4.text = ""
        emailTextField5.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //navigationController?.setNavigationBarHidden(false, animated: true)
        
        view.addSubview(passTextField1)
        view.addSubview(nameTextField2)
        view.addSubview(divTextField3)
        view.addSubview(phoneTextField4)
        view.addSubview(emailTextField5)
        view.addSubview(MyButton)
        view.addSubview(BackButton)
        
        if let std = student {
            passTextField1.text = std.password
            nameTextField2.text = std.name
            divTextField3.text = std.div
            phoneTextField4.text = std.phone
            emailTextField5.text = std.email
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        passTextField1.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 40)
        nameTextField2.frame = CGRect(x: 20, y:passTextField1.bottom + 10, width: view.width - 40, height: 40)
        divTextField3.frame = CGRect(x: 20, y:nameTextField2.bottom + 10, width: view.width - 40, height: 40)
        phoneTextField4.frame = CGRect(x: 20, y: divTextField3.bottom + 10, width: view.width - 40, height: 40)
        emailTextField5.frame = CGRect(x: 20, y: phoneTextField4.bottom + 10, width: view.width - 40, height: 40)
        MyButton.frame = CGRect(x: 20, y: emailTextField5.bottom + 10, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: MyButton.bottom + 10, width: view.width - 40, height: 40)
    }
}




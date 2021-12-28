//
//  NewNotice.swift
//  ass11
//
//  Created by DCS on 21/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNotice: UIViewController {
    var note:Notice?
    
    let temp = CoreDataHandler.shared
    
    public let nameTextField1:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 2
        textField.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        textField.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return textField
    }()
    public let classTextField2:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Description"
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
        button.layer.cornerRadius = 5
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
        let title = nameTextField1.text!
        let descriptions = classTextField2.text!
        
        if let note = note {
            MyButton.setTitle("Update", for: .normal)
            CoreDataHandler.shared.updateNotice(note: note, title: title, descriptions: descriptions) {
                print("updeted...")
                self.resetFields()

            }
        } else {
            CoreDataHandler.shared.insertNotice(title: title, descriptions: descriptions) {
                print("inserted...")
                self.resetFields()

            }
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func resetFields() {
        nameTextField1.text = ""
        classTextField2.text = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField1)
        view.addSubview(classTextField2)
        view.addSubview(MyButton)
        view.addSubview(BackButton)
        
        if let n1 = note {
            nameTextField1.text = n1.title
            classTextField2.text = n1.descriptions
        }
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField1.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 40)
        classTextField2.frame = CGRect(x: 20, y:nameTextField1.bottom + 10, width: view.width - 40, height: 40)
        MyButton.frame = CGRect(x: 20, y: classTextField2.bottom + 10, width: view.width - 40, height: 40)
        BackButton.frame = CGRect(x: 20, y: MyButton.bottom + 10 , width: view.width - 40, height: 40)
    }
    
}

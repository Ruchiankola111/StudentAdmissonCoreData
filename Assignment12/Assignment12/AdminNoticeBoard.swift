//
//  AdminNoticeBoard.swift
//  ass11
//
//  Created by DCS on 21/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminNoticeBoard: UIViewController {
    private var noteArray = [Notice]()
    
    private let myTableView = UITableView()
    
    private let toolbar:UIToolbar = {
        let toolbar = UIToolbar()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        toolbar.items = [space,add]
        return toolbar
    }()
    @objc func handleAdd(){
        print("Add Button Called")
        let vc = NewNotice()
        navigationController?.pushViewController(vc, animated: true)
    }
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteArray = CoreDataHandler.shared.fetchNotice()
        print(noteArray)
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(BackButton)
        myTableView.reloadData()
        myTableView.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))
        
        
        setupTableView()
       
        view.addSubview(toolbar)
        view.addSubview(myTableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let toolbarHGeight:CGFloat = view.safeAreaInsets.top + 20.0
        toolbar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height:toolbarHGeight)
        myTableView.frame = CGRect(x: 0, y: toolbar.bottom, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 80)
        BackButton.frame = CGRect(x: 0, y: view.height - 40, width: view.width, height: 40)
    }
    
}

extension AdminNoticeBoard :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Scell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Scell", for: indexPath)
        let note = noteArray[indexPath.row]
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 10 ,left: 10, bottom: 10, right: 10))
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.layer.cornerRadius = 25
        cell.textLabel!.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        cell.layer.borderWidth = 3
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        cell.textLabel!.numberOfLines = 0
        cell.textLabel?.text = "Name : \(note.title!) \nClass : \(note.descriptions!)  "
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        let vc = NewNotice()
        vc.note = noteArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let note = noteArray[indexPath.row]
        
        
        CoreDataHandler.shared.deleteNotice(note: note){
            self.noteArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

    





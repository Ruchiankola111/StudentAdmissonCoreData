//
//  StudListClassWise.swift
//  Ass12CoreData
//
//  Created by DCS on 24/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ClassList: UIViewController {
    
    public var selClass:String = ""
    private var studArray = [Student]()
    private let myTableView = UITableView()
    private let cLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.07158278674, green: 0.04828194529, blue: 0.1889750957, alpha: 1)
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(selClass)
        studArray = CoreDataHandler.shared.fetchClassWise(sclass: selClass)
        
        myTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myTableView.reloadData()
        cLabel.text="\(selClass) Class Students"
        setupTableView()
        view.addSubview(myTableView)
        view.addSubview(cLabel)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cLabel.frame = CGRect(x: 40, y: 70, width: view.width - 60, height: 30)
        myTableView.frame = CGRect(x: 0, y: cLabel.bottom + 5, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
}

extension ClassList :UITableViewDataSource,UITableViewDelegate {
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Classcell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Classcell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        cell.backgroundColor = #colorLiteral(red: 0.6717784405, green: 0.753040731, blue: 0.9284328818, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 25
        cell.layer.borderWidth = 4
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.4
        
        cell.textLabel?.text = "Name : \(stud.name!) \nClass : \(stud.div!)  \nPhone No. : \(stud.phone!) \nPassword : \(stud.password!)"
        return cell
        
    }
    
}

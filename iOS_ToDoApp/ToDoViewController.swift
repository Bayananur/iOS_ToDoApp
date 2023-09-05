//
//  ViewController.swift
//  iOS_ToDoApp
//
//  Created by Bauyrzhan Seidazymov on 05.09.2023.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var array: [ToDo] = [
        ToDo(title: "someTitle", description: "someDescription", isComplpete: false),
        ToDo(title: "someTitle", description: "someDescription", isComplpete: false),
        ToDo(title: "someTitle", description: "someDescription", isComplpete: false),
        ToDo(title: "someTitle", description: "someDescription", isComplpete: false)]
    
    var tableView = UITableView()
    let label = UILabel()
    
    let newTaskButton = UIButton()
    let editButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        view.backgroundColor = .white
        labelConfigure()
       // tableViewConfigure()
      //  newTaskButtonConstraints()
      //  editButtonCostraints()
    }
    func labelConfigure() {
        view.addSubview(label)
        
        label.text = "Создайте новую задачу, нажмите на кнопку плюс"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    

}


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
        tableViewConfigure()
       // newTaskButtonConstraints()
       // editButtonCostraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        do {
            if let data = defaults.data(forKey: "taskItemArray") {
                let array = try JSONDecoder().decode([ToDo].self, from: data)
                self.array = array
            }
        } catch {
            print("unable to encode \(error)")
        }
        tableView.reloadData()
    }
    
    func saveTasks() {
        let defaults = UserDefaults.standard
        do {
            let encodedata = try JSONEncoder().encode(array)
            defaults.set(encodedata, forKey: "taskItemArray")
        } catch {
            print("unable to encode \(error)")
        }
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
    func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    

}


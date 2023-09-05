//
//  DetailViewController.swift
//  iOS_ToDoApp
//
//  Created by Bauyrzhan Seidazymov on 06.09.2023.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var array: [ToDo] = []
    var titleTextField = UITextField()
    var descriptionTextField = UITextField()
    var saveButton = UIBarButtonItem()
    var isEditView = false
    var editTaskName = ""
    var editTaskDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        titleConfigure()
        descriptionConfigure()
        buttonConfigure()
        
        if isEditView {
            titleTextField.text = editTaskName
            descriptionTextField.text = editTaskDescription
        }
    }
    
    func titleConfigure() {
        titleTextField.placeholder = "Название"
        titleTextField.borderStyle = .roundedRect
        titleTextField.backgroundColor = .white
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func descriptionConfigure() {
        descriptionTextField.placeholder = "Описание"
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.backgroundColor = .white
        descriptionTextField.contentVerticalAlignment = .top
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    func buttonConfigure() {
        saveButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveButtonTapped() {
        let defaults = UserDefaults.standard
        let taskName = titleTextField.text!
        let taskDescription = descriptionTextField.text!
        var newTask = ToDo()
        
        newTask.title = taskName
        newTask.description = taskDescription
        
        do {
            if var array = try? JSONDecoder().decode([ToDo].self, from: defaults.data(forKey: "taskItemArray") ?? Data()) {
                if isEditView {
                    if let index = array.firstIndex(where: { $0.title == editTaskName && $0.description == editTaskDescription }) {
                        array[index] = newTask
                    }
                } else {
                    array.append(newTask)
                }
                let encodedData = try JSONEncoder().encode(array)
                defaults.set(encodedData, forKey: "taskItemArray")
            } else {
                let encodedData = try JSONEncoder().encode([newTask])
                defaults.set(encodedData, forKey: "taskItemArray")
            }
        } catch {
            print("Unable to encode or decode tasks: \(error)")
        }
        navigationController?.popViewController(animated: true)
    }

}

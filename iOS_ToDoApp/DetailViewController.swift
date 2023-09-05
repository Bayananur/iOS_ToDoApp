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
}

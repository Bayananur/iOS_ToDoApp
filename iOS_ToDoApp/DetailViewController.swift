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
    
}

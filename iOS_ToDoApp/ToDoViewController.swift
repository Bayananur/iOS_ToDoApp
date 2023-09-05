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
    
    func editButtonCostraints() {
        if let symbolImage = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
            editButton.setImage(symbolImage, for: .normal)
        }
        editButton.addTarget(self, action: #selector(editTask), for: .touchDown)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.backgroundColor = .systemBlue
        editButton.tintColor = .white
        editButton.layer.cornerRadius = 25
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: newTaskButton.topAnchor, constant: -30),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 50),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func newTaskButtonConstraints() {
        if let symbolImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
            newTaskButton.setImage(symbolImage, for: .normal)
        }
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        newTaskButton.backgroundColor = .systemGreen
        newTaskButton.tintColor = .white
        newTaskButton.layer.cornerRadius = 25
        view.addSubview(newTaskButton)
        newTaskButton.addTarget(self, action: #selector(newTask), for: .touchDown)
        
        NSLayoutConstraint.activate([
            newTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newTaskButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newTaskButton.widthAnchor.constraint(equalToConstant: 50),
            newTaskButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func newTask() {
        let vc = DetailViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationItem.backButtonTitle = "Отменить"
        navigationController?.show(vc, sender: self)
    }
    
    @objc func editTask() {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if tableView.isEditing {
            let reorderControl = UIStackView(arrangedSubviews: [UIView(), UIView()])
            reorderControl.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(reorderControl)
            
            NSLayoutConstraint.activate([
                reorderControl.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                reorderControl.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                reorderControl.widthAnchor.constraint(equalToConstant: 30),
                reorderControl.heightAnchor.constraint(equalToConstant: 30)
            ])
            
            let reorderImage = UIImageView(image: UIImage(systemName: "line.horizontal.3"))
            reorderImage.tintColor = .systemGray
            reorderImage.contentMode = .scaleAspectFit
            reorderImage.translatesAutoresizingMaskIntoConstraints = false
            reorderControl.insertArrangedSubview(reorderImage, at: 1)
            
            tableView.reloadData()
        }
        
        let checkmark = UIButton(type: .system)
        checkmark.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.tintColor = .systemYellow
        checkmark.tag = indexPath.row
        checkmark.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        cell.contentView.addSubview(checkmark)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 17)
        cell.contentView.addSubview(title)
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 12)
        cell.contentView.addSubview(description)
        
        NSLayoutConstraint.activate([
            checkmark.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            checkmark.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),
            checkmark.widthAnchor.constraint(equalToConstant: 25),
            checkmark.heightAnchor.constraint(equalToConstant: 25),
            
            title.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            
            description.leadingAnchor.constraint(equalTo: checkmark.trailingAnchor, constant: 10),
            description.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
        ])
        
        title.text = array[indexPath.row].title
        description.text = array[indexPath.row].description
        
        cell.accessoryType = .detailDisclosureButton
        
        if array[indexPath.row].isComplpete {
            checkmark.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            checkmark.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        let index = sender.tag
        if array[index].isComplpete {
            array[index].isComplpete = false
        } else {
            array[index].isComplpete = true
        }
        saveTasks()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.editTaskName = array[indexPath.row].title
        vc.editTaskDescription = array[indexPath.row].description
        vc.isEditView = true
        navigationItem.backButtonTitle = "Отменить"
        navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveTasks()
        } else if editingStyle == .insert {
        }
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        array.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveTasks()
    }
}




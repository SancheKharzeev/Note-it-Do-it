//
//  ViewController.swift
//  Note it Do it
//
//  Created by Александр Х on 09.04.2023.
//


import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    var models = [NoteItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllItem()
        title = "Note it, Do it"
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.frame = view.bounds
        view.addSubview(myTableView)
        setupUI()
        loadSavedData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllItem()
        loadSavedData()
    }
    
    // MARK: - Button configuration
    let newNoteButton: UIButton = {
        var configButton = UIButton.Configuration.filled()
        configButton.title = "Создать"
        configButton.buttonSize = .large
        configButton.subtitle = "новую заметку"
        configButton.image = UIImage(systemName: "square.and.pencil")
        configButton.imagePlacement = .leading
        configButton.imagePadding = 8

        let button = UIButton(configuration: configButton, primaryAction: nil)
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - NavigationController and target button
    @objc func didTapCreateButton() {
        let rootVC = TextViewVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        getAllItem()
        loadSavedData()
        
    }
    
    private func goToEditNote(_ note: NoteItem) {
      
        let rootVC = EditTextVC()
        rootVC.textView.text = note.name
        rootVC.textField.text = note.title
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        deleteItem(item: note)
    }
    
    // MARK: - setupUI auto layout Button
    private func setupUI() {
        view.addSubview(newNoteButton)
        newNoteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newNoteButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            newNoteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }


    // MARK: - CoreData functions
    func getAllItem() {
        do { // присваеваем нашей переменной моделс список доступных items созданных в coreData
            models = try context.fetch(NoteItem.fetchRequest())
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        catch {
            print("error with getAllItem")
        }
    }
    
    func createItem(name: String, title: String) {
        let newItem = NoteItem(context: context)
        newItem.name = name
        newItem.title = title
        newItem.createData = Date()
        do {
            try context.save()
            getAllItem()
        } catch {
            print("error with createItem")
        }
    }
    
    func deleteItem(item: NoteItem) {
        context.delete(item)
        do {
            try context.save()
            getAllItem()
        } catch {
            print("error with deleteItem")
        }
    }
    func updateItem(item: NoteItem, newName: String) {
        item.name = newName
        do {
            try context.save()
            getAllItem()
        } catch {
            print("error with update item")
        }
    }
    
    func loadSavedData() {
        let request = NoteItem.fetchRequest()
        let sort = NSSortDescriptor(key: "createData", ascending: false)
        request.sortDescriptors = [sort]

        do {
            models = try context.fetch(request)
            print("Got \(models.count) notes")
            myTableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
}


// MARK: - TableView functions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        let model = models[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = model.title
        content.secondaryText = model.createData?.formatted(date: .abbreviated, time: .shortened)
        content.image = UIImage(systemName: "pencil.circle")
        cell.backgroundColor = .systemGray6
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(models[indexPath.row])
/*      let item = models[indexPath.row] // создаем переменную которая указывает на выбранный объект
        
        // создаем всплывающий снизу алерт
        let sheet = UIAlertController(title: "Редактировать запись",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        // Cancel
        sheet.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
       
        // EDIT item
        sheet.addAction(UIAlertAction(title: "Редактировать", style: .default,
                                      handler: {_ in
            let rootVC = EditTextVC()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .fullScreen
            rootVC.textView.text = item.name
            rootVC.textField.text = item.title
            self.present(navVC, animated: true)
            self.deleteItem(item: item)
            self.loadSavedData()
        }))
        // Delete item
        sheet.addAction(UIAlertAction(title: "Delete",
                                      style: .destructive,
                                      handler: {[weak self] _ in
            self?.deleteItem(item: item) // удаляет выделенный объект
            self?.loadSavedData()
        }))
        present(sheet, animated: true)
*/
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = models[indexPath.row]
            deleteItem(item: item)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


   

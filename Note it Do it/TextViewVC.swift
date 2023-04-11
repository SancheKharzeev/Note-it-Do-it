//
//  TextViewVC.swift
//  Note it Do it
//
//  Created by Александр Х on 10.04.2023.
//

import UIKit

class TextViewVC: UIViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.backgroundColor = .systemOrange
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.textColor = .black
        textField.placeholder = "Введите название заметки"
        return textField
    }()
    let textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.backgroundColor = .systemYellow
        textView.font = .systemFont(ofSize: 20, weight: .medium)
        textView.textColor = .black
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новая заметка"
        setupText()
        navigationSetup()
        
    }
    
    func setupText() {
        view.addSubview(textView)
        view.addSubview(textField)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 100),
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    func navigationSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(dismissSelf))
    }
    @objc func dismissSelf() {
        let vc = ViewController()
        guard let text = textView.text,
              let textF = textField.text,
                !text.isEmpty else {
            return
        }
        vc.createItem(name: text, title: textF)
        vc.getAllItem()
        dismiss(animated: true)
    }
}


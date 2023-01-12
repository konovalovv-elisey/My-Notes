//
//  TextViewController.swift
//  My Notes
//
//  Created by Елисей Коновалов on 7.1.23..
//

import UIKit

class TextViewController: UIViewController {
    
    var note = ""
    
    let newText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstreints()
        newText.text = note
    }
    
    private func setupViews() {
        view.addSubview(newText)
    }
    
    private func setConstreints() {
        NSLayoutConstraint.activate([
            newText.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            newText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            newText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            newText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension TextViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(newText.text, forKey: KeySingleton.shared.key)
    }
}

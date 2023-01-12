//
//  ViewController.swift
//  My Notes
//
//  Created by Елисей Коновалов on 7.1.23..
//

import UIKit

class MainViewController: UIViewController {
    
    var note = ""
    private var textVC: TextViewController?
    
    private let notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchController = UISearchController()
    private let toolBar = UIToolbar()
    
    private let idTableView = "idTableView"
    private var isFiltred = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        note = UserDefaults.standard.string(forKey: KeySingleton.shared.key) ?? ""
        print("до - " + note)
        if note == "" {
            note = "Моя первая заметка"
        }
        print("после - " + note)
        
        notesTableView.reloadData()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setToolBar()
        setDelegates()
        setConstreints()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(notesTableView)
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: idTableView)
    }
    
    private func setupNavigationBar() {
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.backButtonTitle = ""
        
        navigationItem.titleView = createCustomTitleView()
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1)
    }
    
    private func setToolBar() {
        
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickPlusButton))
        )
        toolbarItems = items
    }
    
    @objc func onClickPlusButton() {
        let textVC = TextViewController()
        navigationController?.pushViewController(textVC, animated: true)
    }
    
    private func setDelegates() {
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    private func setAlphaForCell(alpha: Double) {
        notesTableView.visibleCells.forEach { cell in
            cell.alpha = alpha
        }
    }
    
    private func createCustomTitleView() -> UIView {
        
        let view = UIView()
        let heightNavBar = navigationController?.navigationBar.frame.height ?? 0
        let widthNavBar = navigationController?.navigationBar.frame.width ?? 0
        view.frame = CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar - 10)
        
        let notesLabel = UILabel()
        notesLabel.text = "My Notes"
        notesLabel.font = UIFont.boldSystemFont(ofSize: 21)
        notesLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        notesLabel.contentMode = .left
        notesLabel.frame = CGRect(x: 10, y: 0, width: widthNavBar, height: heightNavBar / 2)
        view.addSubview(notesLabel)
        return view
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: idTableView, for: indexPath)
        cell.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.textLabel?.text = note
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textVC = TextViewController()
        textVC.note = note
        navigationController?.pushViewController(textVC, animated: true)
    }
}

//MARK: - UISearchControllerDelegate

extension MainViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        isFiltred = true
        setAlphaForCell(alpha: 0.3)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        isFiltred = false
        setAlphaForCell(alpha: 1)
    }
}

//MARK: - setConstreints

extension MainViewController {
    
    private func setConstreints() {
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            notesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            notesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            notesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

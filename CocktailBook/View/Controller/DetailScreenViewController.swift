//
//  DetailScreenViewController.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import UIKit

class DetailScreenViewController: UIViewController, UITableViewDataSource {

    var selectedCocktail: CocktailModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupView()
        registerCell()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func registerCell() {
        tableView.register(CocktailDetailTableCell.self, forCellReuseIdentifier: CocktailDetailTableCell.reuseIdentifier)
        tableView.register(CocktailIngredientsTableCell.self, forCellReuseIdentifier: CocktailIngredientsTableCell.reuseIdentifier)
    }
    
    // Mark:- Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailDetailTableCell.reuseIdentifier, for: indexPath) as! CocktailDetailTableCell
        cell.setupView()
        cell.selectedCocktail = selectedCocktail
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsScreen = DetailScreenViewController()
        navigationController?.pushViewController(detailsScreen, animated: true)
    }
}

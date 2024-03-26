//
//  DetailScreenViewController.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import UIKit

protocol DetailScreenViewControllerDelegate: AnyObject {
    func updateIsFavorite(_ isFavorite: Bool, id: String)
}

class DetailScreenViewController: UIViewController, UITableViewDataSource {
    
    // Custom initializer
    init(selectedCocktail: CocktailModel, cocktailType: CocktailType?) {
        self.selectedCocktail = selectedCocktail
        self.selectedCocktailType = cocktailType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var selectedCocktail: CocktailModel?
    private var selectedCocktailType: CocktailType?
    weak var delegate: DetailScreenViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = selectedCocktailType?.getTypeWithCocktail
        setupView()
        registerCell()
        addFavoriteBtn()
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
    
    private func addFavoriteBtn() {
        let favoriteImageName: ImageName = selectedCocktail?.isFavorite == true ? .heartFill : .heart
        let favoriteImage = UIImage.getImage(favoriteImageName)
        let favoriteButton = UIBarButtonItem(image: favoriteImage, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func favoriteButtonTapped() {
        if let isFavorite = selectedCocktail?.isFavorite {
            selectedCocktail?.isFavorite = !isFavorite
        } else {
            selectedCocktail?.isFavorite = true
        }
        
        let favoriteImageName: ImageName = selectedCocktail?.isFavorite == true ? .heartFill : .heart
        let favoriteImage = UIImage.getImage(favoriteImageName)
        navigationItem.rightBarButtonItem?.image = favoriteImage
        if let isFavorite = selectedCocktail?.isFavorite, let id = selectedCocktail?.id {
            delegate?.updateIsFavorite(isFavorite, id: id)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
    
    // Mark:- Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CocktailDetailTableCell.reuseIdentifier, for: indexPath) as! CocktailDetailTableCell
            cell.setupView()
            cell.selectedCocktail = selectedCocktail
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CocktailIngredientsTableCell.reuseIdentifier, for: indexPath) as! CocktailIngredientsTableCell
            cell.setupView()
            cell.selectedCocktail = selectedCocktail
            return cell
        }
        
        return UITableViewCell()
    }
}

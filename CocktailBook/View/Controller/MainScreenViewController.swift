import UIKit

class MainScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailScreenViewControllerDelegate {
    
    private let viewModel = CocktailViewModel()
    
    private lazy var segment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        for (index, type) in CocktailType.allCases.enumerated() {
            segment.insertSegment(withTitle: type.rawValue, at: index, animated: false)
        }
        segment.selectedSegmentTintColor = UIColor.blue
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segment
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = CocktailType.all.getTypeWithCocktail
        setupView()
        registerCell()
        viewModel.fetchCocktailDetails()
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
        adjustLargeTitleSize()
    }
    
    private func setupView() {
        view.addSubview(segment)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: segment.bottomAnchor, multiplier: 1.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func registerCell() {
        tableView.register(CocktailTableCell.self, forCellReuseIdentifier: CocktailTableCell.reuseIdentifier)
    }
    
    @objc func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        guard let segmentTitle = segment.titleForSegment(at: segment.selectedSegmentIndex), let type = CocktailType(rawValue: segmentTitle) else { return }
        title = type.getTypeWithCocktail
        adjustLargeTitleSize()
        viewModel.filterCocktailDetails(type)
    }
    
    // Mark:- Tableview data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCocktail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailTableCell.reuseIdentifier, for: indexPath) as! CocktailTableCell
        cell.setupView()
        cell.selectedCocktail = viewModel.filteredCocktail?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cocktail = viewModel.filteredCocktail?[indexPath.row] {
            let detailsScreen = DetailScreenViewController(selectedCocktail: cocktail, cocktailType: viewModel.cocktailType)
            detailsScreen.delegate = self
            navigationController?.pushViewController(detailsScreen, animated: true)
        }
    }
    
    func updateIsFavorite(_ isFavorite: Bool, id: String) {
        viewModel.updateIsFavorite(isFavorite, id: id)
    }
    
}

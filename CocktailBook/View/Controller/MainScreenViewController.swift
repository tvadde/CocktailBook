import UIKit

class MainScreenViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = CocktailType.all.getTypeWithCocktail
        setupView()
        viewModel.fetchCocktailDetails()
        viewModel.reloadView = { [weak self] in
            print("name " + (self?.viewModel.cocktailDetails?.first?.name ?? ""))
        }
    }
    
    private func setupView() {
        view.addSubview(segment)
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func segmentedControlValueChanged(_ segment: UISegmentedControl) {
        guard let segmentTitle = segment.titleForSegment(at: segment.selectedSegmentIndex) else { return }
        title = CocktailType(rawValue: segmentTitle)?.getTypeWithCocktail
    }
}

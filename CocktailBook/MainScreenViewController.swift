import UIKit

class MainScreenViewController: UIViewController {
    
    private let viewModel = CocktailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "All Cocktails"
        viewModel.fetchCocktailDetails()
        viewModel.reloadView = { [weak self] in
            print("name " + (self?.viewModel.cocktailDetails?.first?.name ?? ""))
        }
    }
}

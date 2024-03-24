//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by apple on 3/24/24.
//

import UIKit

class CocktailViewModel {
    
    private let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()
    private var cocktailDetails: [CocktailModel]?
    
    var filteredCocktail: [CocktailModel]?
    var reloadView: (() -> ())?
    
    func fetchCocktailDetails() {
        cocktailsAPI.fetchCocktails { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.cocktailDetails = try decoder.decode([CocktailModel].self, from: data)
                    self?.cocktailDetails = self?.cocktailDetails?.sorted(by: { $0.name < $1.name })
                    self?.filterCocktailDetails(.all)
                } catch {
                    print("Decoder error: " + error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filterCocktailDetails(_ type: CocktailType) {
        if type == CocktailType.all {
            filteredCocktail = cocktailDetails
        } else {
            filteredCocktail = cocktailDetails?.filter { $0.type == type.rawValue.lowercased() }
        }
        reloadView?()
    }
}

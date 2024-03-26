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
    private(set) var cocktailType: CocktailType = .all
    
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
        cocktailType = type
        if type == CocktailType.all {
            filteredCocktail = cocktailDetails
        } else {
            filteredCocktail = cocktailDetails?.filter { $0.type == type.rawValue.lowercased() }
        }
        reloadView?()
    }
    
    func updateIsFavorite(_ isFavorite: Bool, id: String) {
        
        if let index = cocktailDetails?.firstIndex(where: { $0.id == id }) {
            cocktailDetails?[index].isFavorite = isFavorite
            cocktailDetails = cocktailDetails?.sorted(by: { (cocktail1, cocktail2) in
                let isFavorite1 = cocktail1.isFavorite ?? false
                let isFavorite2 = cocktail2.isFavorite ?? false
                
                if isFavorite1 && !isFavorite2 {
                    return true
                } else if !isFavorite1 && isFavorite2 {
                    return false
                } else {
                    return cocktail1.name < cocktail2.name
                }
            })
            filterCocktailDetails(cocktailType)
        }
    }
}

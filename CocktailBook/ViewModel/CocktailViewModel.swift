//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by apple on 3/24/24.
//

import UIKit

class CocktailViewModel {
    
    private let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()
    var cocktailDetails: [CocktailModel]?
    
    var reloadView: (() -> ())?
    
    func fetchCocktailDetails() {
        cocktailsAPI.fetchCocktails { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    self?.cocktailDetails = try decoder.decode([CocktailModel].self, from: data)
                    self?.reloadView?()
                } catch {
                    print("Decoder error: " + error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

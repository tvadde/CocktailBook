//
//  CocktailIngredientsTableCell.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import UIKit

class CocktailIngredientsTableCell: UITableViewCell {

    static let reuseIdentifier = "CocktailIngredientsTabelCellIdentifier"

    var selectedCocktail: CocktailModel? {
        didSet {
            if let cocktail = selectedCocktail {
                updateDetails(cocktail)
            }
        }
    }
    
    private lazy var ingredientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    func setupView() {
        selectionStyle = .none
        contentView.addSubview(ingredientStackView)
        
        NSLayoutConstraint.activate([
            ingredientStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.0),
            ingredientStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: ingredientStackView.trailingAnchor, multiplier: 1.0),
            contentView.bottomAnchor.constraint(equalTo: ingredientStackView.bottomAnchor)
        ])
    }
    
    private func updateDetails(_ cocktail: CocktailModel) {
        ingredientStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for ingredient in cocktail.ingredients {
            createSingleIngredientView(ingredient)
        }
        layoutIfNeeded()
    }
    
    private func createSingleIngredientView(_ ingredient: String) {
        let stackView =  UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        ingredientStackView.addArrangedSubview(stackView)
        
        let arrowImage = UIImage(systemName: "arrowtriangle.right.fill")
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.tintColor = .black
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(arrowImageView)
        let arrowView = UIView()
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        arrowView.addSubview(arrowImageView)
        stackView.addArrangedSubview(arrowView)
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: arrowView.centerYAnchor),
            arrowView.widthAnchor.constraint(equalTo: arrowImageView.widthAnchor)
        ])
        let ingredientTextLabel = UILabel()
        ingredientTextLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientTextLabel.numberOfLines = 0
        ingredientTextLabel.text = ingredient
//        ingredientTextLabel.setContentHuggingPriority(.required, for: .vertical)
        stackView.addArrangedSubview(ingredientTextLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ingredientStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

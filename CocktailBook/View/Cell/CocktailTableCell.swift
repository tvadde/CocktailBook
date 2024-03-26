//
//  CocktailTableCell.swift
//  CocktailBook
//
//  Created by apple on 3/24/24.
//

import UIKit

class CocktailTableCell: UITableViewCell {

    static let reuseIdentifier = "CocktailTabelCellIdentifier"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let heartImageView: UIImageView = {
        let heartImage = UIImage.getImage(.heartFill)
        let image = UIImageView(image: heartImage)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let heartView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    var selectedCocktail: CocktailModel? {
        didSet {
            if let cocktail = selectedCocktail {
                updateView(cocktail)
            }
        }
    }

    func setupView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(separatorLine)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.0),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1.0),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        let titleStackView = UIStackView()
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .horizontal
        titleStackView.spacing = 8
        titleStackView.distribution = .fill
        titleStackView.alignment = .center
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(heartView)
        heartView.addSubview(heartImageView)
        NSLayoutConstraint.activate([
            heartImageView.centerYAnchor.constraint(equalTo: heartView.centerYAnchor),
            heartImageView.centerXAnchor.constraint(equalTo: heartView.centerXAnchor),
            heartImageView.leadingAnchor.constraint(equalTo: heartView.leadingAnchor),
            heartImageView.trailingAnchor.constraint(equalTo: heartView.trailingAnchor),
            heartView.widthAnchor.constraint(equalToConstant: 20),
        ])
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(separatorLine)
    }
    
    private func updateView(_ cocktail: CocktailModel) {
     
        titleLabel.text = cocktail.name
        descriptionLabel.text = cocktail.shortDescription
        var color: UIColor? = .black
        heartImageView.isHidden = true
        if let isFavorite = cocktail.isFavorite, isFavorite {
            color = ColorID(rawValue: cocktail.id)?.uiColor
            heartImageView.isHidden = false
        }
        titleLabel.textColor = color
        heartImageView.tintColor = color
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
}

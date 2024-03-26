//
//  CocktailDetailTableCell.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import UIKit

class CocktailDetailTableCell: UITableViewCell {

    static let reuseIdentifier = "CocktailDetailTabelCellIdentifier"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let timeIcon: UIImageView = {
        let timerImage = UIImage.getImage(.timer)
        let imageView = UIImageView(image: timerImage)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cocktailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.lightGray
        return label
    }()
    
    var selectedCocktail: CocktailModel? {
        didSet {
            if let cocktail = selectedCocktail {
                updateDetails(cocktail)
            }
        }
    }
    
    func setupView() {
        selectionStyle = .none
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1.0),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.0),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1.0),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        
        
        let timeStackView = UIStackView()
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.axis = .horizontal
        timeStackView.distribution = .fillProportionally
        timeStackView.spacing = 8
        timeStackView.addArrangedSubview(timeIcon)
        timeStackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(timeStackView)
        stackView.addArrangedSubview(cocktailImage)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    private func updateDetails(_ cocktail: CocktailModel) {
        titleLabel.text = cocktail.name
        descriptionLabel.text = cocktail.longDescription
        timeLabel.text = cocktail.timeWithMintues()
        cocktailImage.image = UIImage(named: cocktail.imageName)
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        cocktailImage.image = nil
        timeLabel.text = nil
    }
}

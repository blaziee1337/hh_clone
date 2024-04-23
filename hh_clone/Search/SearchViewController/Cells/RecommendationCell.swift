//
//  RecommendationCell.swift
//  hh_clone
//
//  Created by Halil Yavuz on 04.04.2024.
//

import UIKit

final class RecommendationViewCell: UICollectionViewCell {
    
    static let identifier = "RecommentaionViewCell"
    
    private let imagesArray: [String] = ["vacanciesRecommend", "star", "listRecommend", "star"]
    private let recommendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private let recommendUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recommendImage)
        addSubview(recommendLabel)
        addSubview(recommendUpButton)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
   private func constraints() {
        
        NSLayoutConstraint.activate([
            
            recommendImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            recommendImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            recommendLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recommendLabel.topAnchor.constraint(equalTo: recommendImage.bottomAnchor, constant: 15),
            
            recommendLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            recommendUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recommendUpButton.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor)
        ])
        
    }
    
    func configure(cellModel: RecommendCellModel) {
        recommendText(text: cellModel.titlle)
        
    }
    
    func setImage(imageName: String) {
        recommendImage.image = UIImage(named: imageName)
        recommendImage.contentMode = .scaleAspectFit
        addSubview(recommendImage)
        
    }
    
    func setRecommendUpButton(text: String) {
        recommendUpButton.setTitle("", for: .normal)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let attributedQuote = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        
        recommendUpButton.setAttributedTitle(attributedQuote, for: .normal)
        recommendUpButton.setTitleColor(.green, for: .normal)
        
        
    }
    
    func recommendText(text: String) {
        recommendLabel.text = text
        recommendLabel.textColor = .white
        recommendLabel.numberOfLines = 0
        recommendLabel.font = .boldSystemFont(ofSize: 14)
        
    }
    
    func hideButton() {
        recommendUpButton.isHidden = true
    }
}

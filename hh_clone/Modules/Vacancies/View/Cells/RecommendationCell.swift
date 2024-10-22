//
//  RecommendationCell.swift
//  hh_clone
//
//  Created by Halil Yavuz on 16.10.2024.
//


import UIKit

final class RecommendationCell: UICollectionViewCell {
    static let identifier = "RecommentaionViewCell"
    
    //MARK: - UI
    
    private let recommendImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recommendUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemGreen, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(recommendImage)
        addSubview(recommendLabel)
        addSubview(recommendUpButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            recommendImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            recommendImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            recommendLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            recommendLabel.topAnchor.constraint(equalTo: recommendImage.bottomAnchor, constant: 16),
            recommendLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
                
            recommendUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            recommendUpButton.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor, constant: -5)
        ])
        
    }
    
     func configure(cell: RecommendModel) {
         recommendLabel.text = cell.title
         recommendUpButton.setTitle(cell.button?.text, for: .normal) 
    }
    
    func setImage(imageName: String) {
        recommendImage.image = UIImage(named: imageName)
        recommendImage.contentMode = .scaleAspectFit
        addSubview(recommendImage)
        
    }
    
}

//
//  GameCollectionViewCell.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    
    private lazy var numberLabel: PaddingAndRoundedLabel = {
        let label = PaddingAndRoundedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = .systemBackground
        label.widthPadding = 10
        label.heightPadding = 10
        label.textAlignment = .center
        return label
    }()
    
    private lazy var crossImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "x")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var contentBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var smilyImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.image = UIImage(named: "grinning")
         imageView.contentMode = .scaleAspectFit
         return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentView()
    }
    
    fileprivate func setUpContentView() {
        
        contentView.addSubview(contentBackgroundView)
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        contentBackgroundView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 8),
            numberLabel.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -8)
        ])
        
    }
    
    func setNumberlabel(number: Int) {
        numberLabel.text = "\(number)"
    }
    
    func addCross() {
        contentBackgroundView.addSubview(crossImageView)
        NSLayoutConstraint.activate([
            crossImageView.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 10),
            crossImageView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 10),
            crossImageView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor, multiplier: 0.3),
            crossImageView.widthAnchor.constraint(equalTo: crossImageView.heightAnchor)
        ])
    }
    
    func removeCross() {
        crossImageView.removeFromSuperview()
    }
    
    func removeSmily() {
        smilyImageView.removeFromSuperview()
    }
    
    func addSmily() {
        contentBackgroundView.addSubview(smilyImageView)
        NSLayoutConstraint.activate([
            smilyImageView.bottomAnchor.constraint(equalTo: contentBackgroundView.bottomAnchor, constant: -15),
            smilyImageView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -15),
            smilyImageView.heightAnchor.constraint(equalTo: contentBackgroundView.heightAnchor, multiplier: 0.5),
            smilyImageView.widthAnchor.constraint(equalTo: smilyImageView.heightAnchor)
        ])
    }
    
}

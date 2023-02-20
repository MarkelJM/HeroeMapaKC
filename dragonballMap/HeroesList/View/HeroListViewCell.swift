//
//  HeroListViewCell.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation
import UIKit
import Kingfisher

class HeroListViewCell : UITableViewCell {
    
    let photoImageView =  {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font  = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false /* muy importante siempre a false!!!*/
        return label
    }()
    
    let descriptionLabel = {
       let label = UILabel()
        
        label.textColor = .systemBlue
        label.font  = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant:  20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
           
            
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor ),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
         
            
            
            
        
        ])
    }
    func configure(_ model: HeroModel) {
        
        /*para alimentar los label etc*/
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.photoImageView.kf.setImage(with: URL(string: model.photo) )
    }

}

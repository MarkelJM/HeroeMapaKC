//
//  HeroDetailView.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation
import UIKit

class HeroDetailView : UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        backgroundColor = .white
        addSubview(photoImageView)
       
        
        NSLayoutConstraint.activate([
            
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            
        
        ])
        
    }
    
    func configure(_ model: HeroModel) {
        
        /*para alimentar los label etc*/
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.photoImageView.kf.setImage(with: URL(string: model.photo) )
    }

    
}

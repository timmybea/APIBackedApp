//
//  PersonCell.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-24.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    static let reuseIdentifier = "personCell"
    
    private let pad: CGFloat = 10
    
    private let cachedImageView: CachedImageView = {
        let view = CachedImageView(frame: .zero)
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        cachedImageView.removeFromSuperview()
        nameLabel.removeFromSuperview()
        emailLabel.removeFromSuperview()
        
        addSubview(cachedImageView)
        NSLayoutConstraint.activate([
            cachedImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: pad),
            cachedImageView.topAnchor.constraint(equalTo: topAnchor, constant: pad),
            cachedImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -pad),
            cachedImageView.widthAnchor.constraint(equalToConstant: frame.height - pad - pad)
            ])
        cachedImageView.layoutIfNeeded()
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: pad),
            nameLabel.leftAnchor.constraint(equalTo: cachedImageView.rightAnchor, constant: pad),
            ])
        
        addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: pad / 2),
            emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0)
            ])
        
        self.selectionStyle = .none
    }
    
    func setup(for person: Person) {
        self.nameLabel.text = "\(person.firstName) \(person.lastName)"
        self.emailLabel.text = "\(person.email.absoluteString)"
        self.cachedImageView.loadImage(from: person.imageEndPoint)
    }

}

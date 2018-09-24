//
//  CachedImageView.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-24.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    private var imageEndPoint: String?
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        layoutActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutActivityIndicator() {
        activityIndicatorView.removeFromSuperview()

        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])

        if self.image == nil {
            activityIndicatorView.startAnimating()
        }
    }

    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func loadImage(from endPoint: String) {
        
        self.imageEndPoint = endPoint
        
        func setImage(_ image: UIImage) {
            DispatchQueue.main.async {
                self.image = image
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        if let imageFromCache = UIImage.imageCache.object(forKey: endPoint as AnyObject) as? UIImage {
            setImage(imageFromCache)
            return
        }
        
        UIImage.cacheImage(from: endPoint) { (image) in
            guard let imageFromCache = image else {
                return
            }
            setImage(imageFromCache)
        }
    }
}

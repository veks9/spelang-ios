//
//  UIImageView+.swift
//  Pokemons
//
//  Created by Vedran Hernaus on 08.09.2022..
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(_ urlString: String?) {
        guard let urlString = urlString else { return }
        kf.indicatorType = .activity
        kf.setImage(with: urlString.toURL())
    }
    
    func setImage(_ url: URL?, spinnerViewColor: UIColor = .white) {
        guard let url = url else { return }
        startKFIndicator(spinnerViewColor: spinnerViewColor)
        kf.setImage(with: url)
    }
    
    func startKFIndicator(spinnerViewColor: UIColor = .white) {
        kf.indicatorType = .activity
        (kf.indicator?.view as? UIActivityIndicatorView)?.color = spinnerViewColor
    }
}

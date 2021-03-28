//
//  UIImageViewExtension.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "noImage")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "noImage")
                }
            }
        }
    }
}

//
//  UIViewControllerExtension.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showIndicator() {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = "Loading..."
        Indicator.isUserInteractionEnabled = false
        Indicator.show(animated: true)
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

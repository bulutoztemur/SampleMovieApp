//
//  SplashViewController.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 25.03.2021.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {

    @IBOutlet weak var splashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPage()
    }
    
    func setupPage(){
        self.hideNavigationBar()
        if(ConnectivityManager.checkInternetConnection()) {
            self.updateLabelOnSplash()
        } else {
            self.createNoInternetAlert()
        }
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
                
    func updateLabelOnSplash() {
        RemoteConfigManager.fetchDataFromRemoteConfig(myKey: Constants.SplashScreenLabelKeyForRC) { (valueForKey) in
            self.splashLabel.text = valueForKey
            self.transitionToMainPageWithDelay()
        }
    }
    
    func transitionToMainPageWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Constants.DelayTimeForTransitionToMainPage)) { [weak self] in
            self?.transitionToMainPage()
        }
    }

    func transitionToMainPage() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func createNoInternetAlert() {
        let alert = UIAlertController(title: Constants.NoInternetAlertTitle, message: Constants.NoInternetAlertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OKText, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

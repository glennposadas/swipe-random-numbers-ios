//
//  HomeSettingsViewController.swift
//  SwipeLetters
//
//  Created by Glenn Posadas on 1/20/21.
//

import GoogleMobileAds
import UIKit

class HomeSettingsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var button_Start: UIButton!
    @IBOutlet weak var view_AdContainer: UIView!
    @IBOutlet weak var button_RandomizeLetters: UIButton!
    
    private var bannerView: GADBannerView!
    private var interstitial: GADInterstitial!
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRandomizeButton()
        animateStartButton()
        setupBannerAd()
        setupInterstitialAd()
    }
    
    private func setupRandomizeButton() {
        let useRandomizeLetters = AppDefaults.getObjectWithKey(.useRandomizeLetters, type: Bool.self)
        let name = useRandomizeLetters == true ? "ic_checkbox_on" : "ic_checkbox_off"
        let image = UIImage(named: name)
        button_RandomizeLetters.setImage(image, for: .normal)
    }
    
    private func animateStartButton() {
        button_Start.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        
        UIView.animate(
            withDuration: 10.0,
            delay: 0,
            usingSpringWithDamping: 0.20,
            initialSpringVelocity: 5.0,
            options: .allowUserInteraction,
            animations: {
                self.button_Start.transform = CGAffineTransform.identity
            }) { (complete) in
            if complete {
                self.animateStartButton()
            }
        }
    }
    
    private func setupBannerAd() {
        view_AdContainer.backgroundColor = .clear
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        bannerView.adUnitID = PubKeys.Admob.homeBannerAd
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view_AdContainer.addSubview(self.bannerView)
        bannerView.bottomAnchor.constraint(equalTo: self.view_AdContainer.bottomAnchor).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: self.view_AdContainer.centerXAnchor).isActive = true
    }
    
    private func setupInterstitialAd() {
        interstitial = GADInterstitial(adUnitID: PubKeys.Admob.startInsterstitialAd)
        interstitial.delegate = self
        interstitial.load(GADRequest())
    }
    
    var tries = 1
    @IBAction func start(_ sender: Any) {
        if ENVManager.currentEnv == .development {
            self.performSegue(withIdentifier: "start", sender: nil)
            return
        }
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            tries = 0
        } else {
            print("Ad wasn't ready")
            delay(1) {
                if self.tries <= 2 {
                    self.start(sender)
                    self.tries += 1
                } else {
                    self.performSegue(withIdentifier: "start", sender: nil)
                }
            }
        }
    }
    
    @IBAction func randomizeLettersToggled(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        
        let useRandomizeLetters = AppDefaults.getObjectWithKey(.useRandomizeLetters, type: Bool.self) ?? false
        AppDefaults.store(!useRandomizeLetters, key: .useRandomizeLetters)
        setupRandomizeButton()
        
    }
}

// MARK: - GADInterstitialDelegate

extension HomeSettingsViewController: GADInterstitialDelegate {
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        performSegue(withIdentifier: "start", sender: nil)
    }
}

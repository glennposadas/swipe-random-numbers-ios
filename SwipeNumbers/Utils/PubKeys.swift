//
//  PubKeys.swift
//  SwipeLetters
//
//  Created by Glenn Posadas on 1/20/21.
//

import Foundation

/**
 Handles the keys that can be safely put here. Such as Admob keys.
 ref: https://developers.google.com/admob/ios/test-ads
 */
struct PubKeys {
    struct Admob {
        static let homeBannerAd = ENVManager.currentEnv == .production ? "ca-app-pub-7352177825579783/9486302119" : "ca-app-pub-3940256099942544/2934735716"
        static let startInsterstitialAd = ENVManager.currentEnv == .production ? "ca-app-pub-7352177825579783/7790077060" : "ca-app-pub-3940256099942544/4411468910"
    }
}


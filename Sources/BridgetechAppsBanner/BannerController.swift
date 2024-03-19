//
//  File.swift
//  
//
//  Created by Mark Bridges on 17/03/2024.
//

import Foundation

public final class BannerController: ObservableObject {
    
    @Published var currentAppAd: AppAd?
    
    public let excludedAppBundleIds: Set<String>
    public let adChangeInterval: TimeInterval
    
    private var timer: Timer?
    
    private let allAppAds: Set<AppAd> = [
        AppAd(bundleId: "com.bridgetech.WhiteNoise",
              appStoreId: "1459538265",
              adTitle: "White Noise: Sound Machine",
              adDescription: "Unwind in an Instant with Soothing Sounds.",
              imageName: "whitenoise"),
        AppAd(bundleId: "com.bridgetech.off-free",
              appStoreId: "529923825",
              adTitle: "Off",
              adDescription: "Control Your Computer from Anywhere, Anytime.",
              imageName: "off"),
        AppAd(bundleId: "com.bridgetech.Jigsaw",
              appStoreId: "6474455584",
              adTitle: "Puzzles Daily",
              adDescription: "Piece by Piece, Day by Day – Your Puzzle Journey Awaits.",
              imageName: "puzzle"),
        AppAd(bundleId: "com.bridgetech.bloodpressure",
              appStoreId: "1567028995",
              adTitle: "Blood Pressure Connect",
              adDescription: "Understand Your Heart, Improve Your Health.",
              imageName: "bloodpressure"),
        AppAd(bundleId: "com.bridgetech.clued-up",
              appStoreId: "497840918",
              adTitle: "Clued Up",
              adDescription: "Step Up Your Game, Crack the Cluedo Code.",
              imageName: "cluedup"),
        AppAd(bundleId: "com.bridgetech.PitchPerfectToddler",
              appStoreId: "1532873011",
              adTitle: "Perfect Pitch Toddler",
              adDescription: "Tune Your Child's Ear to Musical Excellence.",
              imageName: "perfectpitch"),
    ]
    
    private var unshownAppAds: Set<AppAd> = []
    
    @Published public var enabled: Bool = true {
        didSet {
            if enabled {
                startAdChangeTimer()
                showNextAppAd()
            } else {
                timer?.invalidate()
                currentAppAd = nil
            }
        }
    }
    
    public init(excludedAppBundleIds: Set<String> = [], adChangeInterval: TimeInterval = 30) {
        self.excludedAppBundleIds = excludedAppBundleIds
        self.adChangeInterval = adChangeInterval
        showNextAppAd()
        startAdChangeTimer()
    }
    
    private func startAdChangeTimer() {
        timer = .scheduledTimer(withTimeInterval: adChangeInterval,
                                repeats: true,
                                block: { [weak self] _ in
            guard let self else { return }
            self.showNextAppAd()
        })
    }
    
    private func showNextAppAd() {
        if unshownAppAds.isEmpty {
            unshownAppAds = allAppAds.filter{ !self.excludedAppBundleIds.contains($0.bundleId) }
        }
        let nextAppAd = unshownAppAds.randomElement()!
        unshownAppAds.remove(nextAppAd)
        currentAppAd = nextAppAd
    }
    
}


import Foundation
import SwiftUI

public struct AppAd: Identifiable, Equatable, Hashable {
    
    public var id: String {
        return bundleId
    }
    
    public let bundleId: String
    public let appStoreId: String
    public let adTitle: LocalizedStringResource
    public let adDescription: LocalizedStringResource
    public let imageName: String
    
    var image: Image {
        guard let uiimage = UIImage(named: imageName, in: .module, with: nil) else {
            return Image("")
        }
        return Image(uiImage: uiimage)
    }
    
    var appStoreURL: URL {
        URL(string: "https://apps.apple.com/app/id" + appStoreId)!
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(bundleId)
    }
}

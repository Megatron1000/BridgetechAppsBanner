import SwiftUI
import Combine

struct BridgetechAppsBannerContent : View {
    
    @Binding var appAd: AppAd?
    
    var body: some View {
        if let appAd {
            HStack {
                appAd.image
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) // This gives the pill shape
                VStack(alignment: .leading, content: {
                    Text(appAd.adTitle)
                        .font(.headline)
                        .lineLimit(1)
                    Text(appAd.adDescription)
                        .font(.caption)
                        .lineLimit(2)
                })
                Spacer(minLength: 0)
            }
        } else {
            EmptyView()
        }

    }
}

public struct BridgetechAppsBannerContainer : View {
    
    public struct Config {
        public init(backgroundColor: Color, foregroundColor: Color, shadowRadius: CGFloat, cornerRadius: CGFloat) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.shadowRadius = shadowRadius
            self.cornerRadius = cornerRadius
        }
        
        public let backgroundColor: Color
        public let foregroundColor: Color
        public let shadowRadius: CGFloat
        public let cornerRadius: CGFloat
        
        public static let standard: Config = Config(backgroundColor: .blue,
                                             foregroundColor: .white,
                                             shadowRadius: 4,
                                             cornerRadius: 20)
    }
    
    @State public var config: Config
    
    @EnvironmentObject var bannerController: BannerController
    public var onAppAdAppear: ((AppAd) -> ())?
    public var onAppAdTap: ((AppAd) -> ())?
        
    public init(config: BridgetechAppsBannerContainer.Config,
                onAppAdAppear: ((AppAd) -> ())? = nil,
                onAppAdTap: ((AppAd) -> ())? = nil) {
        self.config = config
        self.onAppAdAppear = onAppAdAppear
        self.onAppAdTap = onAppAdTap
    }
        
    public var body: some View {
        if let currentAppAd = bannerController.currentAppAd {
            BridgetechAppsBannerContent(appAd: $bannerController.currentAppAd)
                .padding()
                .background(config.backgroundColor)
                .foregroundColor(config.foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: config.cornerRadius, style: .continuous))
                .shadow(radius: config.shadowRadius)
                .onTapGesture {
                    UIApplication.shared.open(currentAppAd.appStoreURL,
                                              options: [:]) { success in
                        if success {
                            onAppAdTap?(currentAppAd)
                        }
                    }
                }
                .animation(.default, value: bannerController.currentAppAd)
                .onChange(of: bannerController.currentAppAd, perform: { value in
                    guard let value else {
                        return
                    }
                    onAppAdAppear?(value)
                })
                .onAppear() {
                    onAppAdAppear?(currentAppAd)
                }
        }
    }
}



#Preview(body: {
    VStack {
        Spacer()
        BridgetechAppsBannerContainer(config: .standard)
            .padding()
            .environmentObject(BannerController(adChangeInterval: 2))
    }
})

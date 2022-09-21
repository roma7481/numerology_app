import UIKit
import Flutter
import google_mobile_ads
//import FBAudienceNetwork

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let nativeAdFactory = HealingNativeAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "healingAdFactory", nativeAdFactory: nativeAdFactory)
    if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }
//    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ kGADSimulatorID ]
//    FBAdSettings.setAdvertiserTrackingEnabled(true)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

import UIKit
import Flutter
import google_mobile_ads
//import FBAudienceNetwork

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let regionChannel = FlutterMethodChannel(
      name: "getRegionCode",
      binaryMessenger: controller.binaryMessenger
    )

    regionChannel.setMethodCallHandler { call, result in
      if call.method == "get" {
        let regionCode = Locale.current.regionCode ?? "US"
        result(regionCode)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

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

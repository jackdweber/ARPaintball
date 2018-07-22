import UIKit
import OktaAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let hd = UserDefaults.standard.object(forKey: "hd") {
            
        } else {
            UserDefaults.standard.setValue(false, forKey: "hd")
        }
        if let hd = UserDefaults.standard.object(forKey: "cheats") {
            
        } else {
            UserDefaults.standard.setValue(false, forKey: "cheats")
        }
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return OktaAuth.resume(url, options: options)
    }
}


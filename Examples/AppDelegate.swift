import UIKit
import OktaAuth
import MultipeerConnectivity

let peerid = MCPeerID(displayName: UIDevice.current.name)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let hd = UserDefaults.standard.object(forKey: "hd") {
            
        } else {
            UserDefaults.standard.setValue(false, forKey: "hd")
        }
        
        if let hd = UserDefaults.standard.object(forKey: "multi") {
            
        } else {
            UserDefaults.standard.set(false, forKey: "multi")
        }
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return OktaAuth.resume(url, options: options)
    }
}



import UIKit
import CoreTelephony

func RGBACOLOR(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: (red) / 255.0, green: (green) / 255.0, blue: (blue) / 255.0, alpha: alpha)
}

func RGBCOLOR(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return RGBACOLOR(red: red, green: green, blue: blue, alpha: 1)
}


struct SF {
    public static var storyBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    ///  App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    
    ///  Returns app's version number
    public static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    ///  Return app's build number
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    ///  Return app's bundle ID
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    ///  Returns both app's version and build numbers "v0.3(7)"
    public static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }
    
    ///  Return device version ""
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    ///  Returns true if DEBUG mode is active //TODO: Add to readme
    public static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    ///  Returns true if RELEASE mode is active //TODO: Add to readme
    public static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }
    
    ///  Returns true if its simulator and not a device //TODO: Add to readme
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
    
    ///  Returns true if its on a device and not a simulator //TODO: Add to readme
    public static var isDevice: Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }
    
    ///  Check if app is running in TestFlight mode.
    public static var isInTestFlight: Bool {
        // http://stackoverflow.com/questions/12431994/detect-testflight
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }
    
    ///  Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    ///  Returns the top ViewController
    public static var topMostViewController: UIViewController? {
        let topVC = UIApplication.topViewController()
        if topVC == nil {
            print("EZSwiftExtensions Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
        }
        return topVC
    }
    
    ///  Returns current screen orientation
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    /// EZSwiftExtensions
    public static var horizontalSizeClass: UIUserInterfaceSizeClass {
        return topMostViewController?.traitCollection.horizontalSizeClass ?? UIUserInterfaceSizeClass.unspecified
    }
    
    /// EZSwiftExtensions
    public static var verticalSizeClass: UIUserInterfaceSizeClass {
        return topMostViewController?.traitCollection.verticalSizeClass ?? UIUserInterfaceSizeClass.unspecified
    }
    
    ///  Returns screen width
    public static var screenWidth: CGFloat {
        #if os(iOS)
        if screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.width
        #endif
    }
    
    ///  Returns screen height
    public static var screenHeight: CGFloat {
        #if os(iOS)
        if SF.screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.height
        #endif
    }
    
    ///  Returns StatusBar height
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    ///  Return screen's height without StatusBar
    public static var screenHeightWithoutStatusBar: CGFloat {
        if SF.screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    
    // MARK: - Other Functions
    
    ///  Returns the locale country code. An example value might be "ES". //TODO: Add to readme
    public static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    
    func countryCodeOfCellularProvider() -> String {
        let countryCode = CTTelephonyNetworkInfo().subscriberCellularProvider?.mobileNetworkCode
        return countryCode ?? ""
    }
    
    //Call to particular number
    func callToPhone(phone: String) {
        if phone.length > 0 {
            let chars = NSCharacterSet(charactersIn: "() -") as CharacterSet
            let phoneNumber = phone.components(separatedBy: chars).joined(separator: "")
            if canOpenURL(urlSchema: "tel://\(phoneNumber)") {
                openURL(urlSchema: "tel://\(phoneNumber)")
            }
        }
    }
    
    func canOpenURL(urlSchema : String) -> Bool {
        return SF.sharedApplication.canOpenURL(URL(string: urlSchema)!)
    }
    
    func openURL(urlSchema : String) {
        SF.sharedApplication.open(URL(string: urlSchema)!, options: [:], completionHandler: nil)
    }
    
    //TODO: Document this, add tests to this
    ///  Iterates through enum elements, use with (for element in ez.iterateEnum(myEnum))
    /// http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) { $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee } }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
    #if os(iOS)
    ///  Check if device is iPad.
    public static var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    ///  Check if device is iPhone.
    public static var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    #endif
    
    #if os(iOS) || os(tvOS)
    ///  Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    ///  Key window (read only, if applicable).
    public static var keyWindow: UIView? {
        return sharedApplication.keyWindow
    }
    
    ///  Shared instance UIApplication.
    public static var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    #endif
    
    public static var currentLanguage: String {
        return NSLocale.preferredLanguages.first!
    }
    
    ///  Shared instance of standard UserDefaults (read-only).
    public static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    public static var documentsPath: String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath
    }
   
    
    // MARK: - Dispatch
    
    ///  Runs the function after x seconds
    static func dispatchDelay(_ second: Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    ///  Runs function after x seconds
    static func runThisAfterDelay(seconds: Double, after: @escaping () -> ()) {
        runThisAfterDelay(seconds: seconds, queue: DispatchQueue.main, after: after)
    }
    
    //TODO: Make this easier
    ///  Runs function after x seconds with dispatch_queue, use this syntax: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
    static func runThisAfterDelay(seconds: Double, queue: DispatchQueue, after: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
    
    ///  Submits a block for asynchronous execution on the main queue
    static func runThisInMainThread(_ block: @escaping ()->()) {
        DispatchQueue.main.async(execute: block)
    }
    
    ///  Runs in Default priority queue
    static func runThisInBackground(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    ///  Runs every second, to cancel use: timer.invalidate()
    static func runThisEvery(seconds: TimeInterval, startAfterSeconds: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    ///  Downloads image from url string
    static func requestImage(_ url: String, success: @escaping (UIImage?) -> Void) {
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    /// 
    static func requestURL(_ url: String, success: @escaping (Data?) -> Void, error: ((NSError) -> Void)? = nil) {
        guard let requestURL = URL(string: url) else {
            assertionFailure("EZSwiftExtensions Error: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(
            with: URLRequest(url: requestURL),
            completionHandler: { data, response, err in
                if let e = err {
                    error?(e as NSError)
                } else {
                    success(data)
                }
        }).resume()
    }
}




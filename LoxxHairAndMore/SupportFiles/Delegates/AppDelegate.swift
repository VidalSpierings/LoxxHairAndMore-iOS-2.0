import MMDrawerController
import Reachability
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var centerContainer: MMDrawerController!
    var centerViewController: UIViewController!
    var menuViewController: MenuViewController!
                
    var indicatorView: UIView!
            
    private var reachability: Reachability? = nil
    
    private var errorAlert: UIAlertController? = nil
    
    private var centerNav: UINavigationController? = nil
    private var menuNav: UINavigationController? = nil
    
    private var mainStoryboard: UIStoryboard? = nil
        
    private var userDefaults = UserDefaults()
        
    let dynamicViewBackgroundColor =
    UIColor(red: 1.00, green: 0.86, blue: 0.77, alpha: 1.00) | UIColor(red: 0.78, green: 0.67, blue: 0.58, alpha: 1.00)
    // RGB Light: 255, 220, 196 | RGB Dark: 198, 172, 147
    
    let dynamicTableViewAreaBackgroundColor = UIColor(red: 0.99, green: 0.93, blue: 0.87, alpha: 1.00) | UIColor(red: 0.80, green: 0.73, blue: 0.67, alpha: 1.00)
    // RGB Light: 253, 238, 223 | RGB Dark: 204, 186, 170
    
    // See 'MyCustomColorOperator' class for reference
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if #available(iOS 13.0, *) {
            
            
        } else {
            
            window = UIWindow()
            
            initUIWindow(enableUserInteractionRightAway: false)
            
            setReachabilityNotifier()
            
        }
        
        return true
        
    }
    
    private func initUIWindow(enableUserInteractionRightAway: Bool){
        
        print("The viewcontroller that is currently active: \(MyConstants.currently_active_center_viewController)")
                
        initCenterViewController()
        
        menuViewController = mainStoryboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        
        initNavContainer(enableUserInteractionRightAway: enableUserInteractionRightAway)
                                                
    }
    
    private func initCenterViewController(){
        
        window?.isUserInteractionEnabled = false
        // ensure user can not use app while essential data is being fetched from server and layout is being loaded
        
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
    }
    
    private func initNavContainer(enableUserInteractionRightAway: Bool){
        
        centerViewController = mainStoryboard?.instantiateViewController(withIdentifier: MyConstants.currently_active_center_viewController)
                
        centerNav = UINavigationController(rootViewController: centerViewController)
        menuNav = UINavigationController(rootViewController: menuViewController)
        
        centerContainer = MMDrawerController(center: centerNav, leftDrawerViewController: menuNav)
        
        centerContainer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView;
        centerContainer.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
        
        window!.rootViewController = centerContainer
        window!.makeKeyAndVisible()
        
        if (enableUserInteractionRightAway) {window?.isUserInteractionEnabled = true}
        
    }
    
    private func fetchDataFromServer(){
                
        let timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(showLoadingScreen), userInfo: nil, repeats: false)
        // Wait for exactly 2.5 seconds before showing loading screen
        
        self.window?.isUserInteractionEnabled = false
        // disable user interaction when data is being fetched. The initial user interaction disabled setting is already enabled at startup, so this above line here is exclusively for the case where the user started the app with an inactive internet connection (which enables screen interaction) and then re-establishes a connection, which automatically makes the app attempt to fetch the most recent data and show the loading screen troughout this process, and thus the app will have to disable user interaction until all data is fetched
                    
        NetworkManager().fetchAllData({
                                                    
            timer.invalidate()
            // if timer for showing loading screen was waiting less than 2.5 seconds, cancel/invalidate it
                    
            print("server value in background thread: \(self.userDefaults.integer(forKey: MyConstants.show_first_startup_message_entry_key))")
            
            DispatchQueue.main.async {
                
                let showMessageBoolean = self.userDefaults.bool(forKey: MyConstants.show_first_startup_message_boolean_key)
                let number_entry_from_db = self.userDefaults.integer(forKey: MyConstants.show_first_startup_message_entry_key)
                let number_entry_saved_locally = self.userDefaults.value(forKey: MyConstants.show_startup_message_entry_currently_known_key) as? Int ?? 0
                
                let messageTitle = self.userDefaults.string(forKey: MyConstants.first_startup_message_title_key) ?? "(Could not retrieve error title)"
                let messageDescription = self.userDefaults.string(forKey: MyConstants.first_startup_message_description_key) ?? "(Could not retrieve error message)"
                    
                print("server value regular \(self.userDefaults.integer(forKey: MyConstants.show_first_startup_message_entry_key))")
                print("local value \(self.userDefaults.value(forKey: MyConstants.show_startup_message_entry_currently_known_key) as? Int ?? 0)")
                            
                
                self.initUIWindow(enableUserInteractionRightAway: true)
                // ensure user can use app after all essential data is done loading
                
                if self.indicatorView != nil {
                    
                    self.indicatorView.isHidden = true
                    
                    #if DEBUG
                    self.indicatorView.backgroundColor == UIColor.red
                    
                    // when user interation is enabled again after the most recently available data is loaded into the UI and the indicatorView has been made invisible, set the indicator view's background to red if the app is being run in debug mode. When debugging the application, and more specifically, running UItests, the changing of the backgroundcolor to red at this exact line of code serves as a 'signal' that user app interaction is currently enabled, allowing for the UITests to recognize that from this line of code forward, it is ready to start potential operations such as for example pressing buttons in the ViewController(s).
                    #endif
                    
                    
                    
                }
                    
                if (showMessageBoolean == true && number_entry_from_db != number_entry_saved_locally) {
                                                        
                    self.errorAlert = MyErrorAlertBuilder().displayStandardAlertFromUIWindow(
                        title: messageTitle, message: messageDescription)
                                                        
                    self.userDefaults.set(number_entry_from_db, forKey: MyConstants.show_startup_message_entry_currently_known_key)
                
            }
                
        }
                                
        })
    }
    
    private func setReachabilityNotifier(){
        
        do {
            
            try reachability = Reachability()
            
        } catch {
            
            MyLogger.logMessage(message: "Couldn't instantiate Reachability object", category: MyLogger.log_category_network)
            
        }
                
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        do {
            
            try reachability?.startNotifier()
                                    
        } catch {
            
            MyLogger.logMessage(message: "Couldn't start reachability notifier", category: MyLogger.log_category_network)
            
        }
        
    }
    
    @objc private func reachabilityChanged(note: Notification){
        
        let reachability = note.object as? Reachability
                
        if reachability?.connection != .unavailable {
            
            MyLogger.logMessage(message: "connected", category: MyLogger.log_category_network)
            
            self.reachability?.stopNotifier()
            
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
                                        
            errorAlert?.dismiss(animated: true, completion: nil)
            
            fetchDataFromServer()
            
            // run code if a connection is available
                                                                        
        } else {
            
            errorAlert = MyErrorAlertBuilder().displayStandardErrorAlertFromUIWindowNonVoid(errorTitle: NSLocalizedString("unable to connect to internet", comment: ""), errorMessage: NSLocalizedString("unable to connect to internet description", comment: ""), logText: "not connected", logCategory: MyLogger.log_category_network)
            
            // inform user that no active internet connection was found
            
            self.window?.isUserInteractionEnabled = true
            // ensure user can use app when there is no active internet connection
        }
        
    }
    
    @objc private func showLoadingScreen(){
        
        initIndicatorView()
        initIndicator()
        
    }
    
    private func initIndicator(){
            
            let indicator = UIActivityIndicatorView()
            
            indicator.initStyle()
            // see 'MyTypeExtensionFunctions.swift for explanation

            self.indicatorView.addSubview(indicator)
            
            let centerXConstraint = indicator.centerXAnchor.constraint(equalTo: self.indicatorView.centerXAnchor)
            
            let centerYConstraint = indicator.centerYAnchor.constraint(equalTo: self.indicatorView.centerYAnchor)
        
            // center loading indicator in center of the screen
            
            let heightConstraint = indicator.heightAnchor.constraint(equalToConstant: 20)
                    
            let widthConstraint = indicator.widthAnchor.constraint(equalToConstant: 20)
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
                                    
            self.indicatorView.addConstraints([centerXConstraint, centerYConstraint, heightConstraint, widthConstraint])
            
            indicator.color = .white
            
            indicator.startAnimating()
                                        
    }
    
    private func initIndicatorView(){
               
        indicatorView = UIView()
        
        window?.addSubview(indicatorView)
                            
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
                        
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // make the loading screen somewhat transparent, with a black-colored undertone
        
        indicatorView.isOpaque = true
        
        let leadingContraint = indicatorView.leadingAnchor.constraint(equalTo: window?.leadingAnchor ?? NSLayoutXAxisAnchor(), constant: 0)
        let trailingConstraint = indicatorView.trailingAnchor.constraint(equalTo: window?.trailingAnchor ?? NSLayoutXAxisAnchor(), constant: 0)
        let topConstraint = indicatorView.topAnchor.constraint(equalTo: window?.topAnchor ?? NSLayoutYAxisAnchor(), constant: 0)
        let bottomConstraint = indicatorView.bottomAnchor.constraint(equalTo: window?.bottomAnchor ?? NSLayoutYAxisAnchor(), constant: 0)
        
        window?.addConstraints([leadingContraint, trailingConstraint, topConstraint, bottomConstraint])
        
    }
    
}


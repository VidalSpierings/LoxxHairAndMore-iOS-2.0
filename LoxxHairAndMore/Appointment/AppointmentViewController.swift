import WebKit
import MMDrawerController

class AppointmentViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    
    @IBOutlet weak private var bottomToolbar: UIToolbar!
    
    @IBOutlet weak private var topNavigationBar: UINavigationItem!
    
    @IBOutlet weak private var reloadPageButton, previousPageButton: UIBarButtonItem!
    
    @IBOutlet weak private var webViewLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var navigationBar: UINavigationBar!
    
    @IBOutlet weak private var statusbarOverlapViewHeightConstraint: NSLayoutConstraint!
    
    // variables from storyboard
    
    private var wkWebView: WKWebView! = nil
    
    private var webView: UIWebView! = nil
    
    private var isInitialPageLoaded = false
        
    private var viewModel = AppointmentViewModel()
    
    // swift variables
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        MyConstants.currently_active_center_viewController = MyConstants.appointmentViewControllerIdentifier
        
        statusbarOverlapViewHeightConstraint.constant = MyUIConstants().statusbarOverlapViewHeightConstraint
        
        self.navigationController?.isNavigationBarHidden = true
        
        let dynamicBackgroundColor: UIColor = .white | .black
        
        view.backgroundColor = dynamicBackgroundColor
        
        initLoadingIndicator()
                
        if #available(iOS 11.0, *) {
            
            initWkWebView()
            
        } else {
            
            initWebView()
            
        }
                
        // use appropriate webView protocol according to users' current iOS version
                                    
    }
    
    private func initLoadingIndicator(){
        
        webViewLoadingIndicator.initStyle()
        // see 'MyTypeExtensionFunctions.swift' for explanation
        
        webViewLoadingIndicator.hidesWhenStopped = true
        
        webViewLoadingIndicator.startAnimating()

        // webView will stop animating and hide when initial webpage is loaded
        
    }
    
    func webView(_ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        
        stopLoadingIndicatorAnimation()
        
      }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
       print("webview failed to load")
                
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        print("reason why webview is not loading: \(error.localizedDescription)")
        
    }


    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        stopLoadingIndicatorAnimation()
    }
    
    private func stopLoadingIndicatorAnimation(){
        
        if (!isInitialPageLoaded) {
            
            webViewLoadingIndicator.stopAnimating()
            
            isInitialPageLoaded = true
            
        }
                
    }
    
    private func initWebView(){
        
        initAndCleanAppropriateWebViewWebView()
        
        initWebNavButtons()
                
        initWebViewDimens()
        
        initWebViewDesign()
                
        loadWebpage(uiWebView: webView, wkWebView: nil)
        
    }
    
    private func initWkWebView(){
        
        initAndCleanAppropriateWebViewWkWebView()
        
        initWebNavButtons()
        
        initWebViewDimens()
        
        initWkWebViewDesign()
                        
        loadWebpage(uiWebView: nil, wkWebView: wkWebView)

        //webViewLoadingIndicator.stopAnimating()
                                
    }
    
    private func initWkWebViewDesign(){
        
        wkWebView.isOpaque = false
        wkWebView.backgroundColor = UIColor.clear
        wkWebView.scrollView.backgroundColor = UIColor.clear
        
    }
    
    private func initWebViewDesign(){
        
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
                
    }
    
    // WebView or WkWebView is made opaque so loading icon can be shown
    
    @objc private func backButtonTapped(sender: UIBarButtonItem){
        
        if wkWebView != nil && wkWebView.canGoBack {
            
            wkWebView.goBack()
            
        } else if webView != nil && webView.canGoBack {
            
            webView.goBack()
            
        } else {
            
            MyLogger.logMessage(message: "unable to go to previous page", category: MyLogger.log_category_ui_functionality)
        }
        
        // init 'back' button functionality according to active webView protocol. Inform log when user can not go back on page, for example when the back button is pressed upon the initial page being active currently
        
    }
    
    @objc private func reloadPageButtonTapped(sender: UIBarButtonItem){
        
        if wkWebView != nil {
            
            wkWebView.reload()
            
        } else if webView != nil {
            
            webView.reload()
            
        } else {
            
            MyLogger.logMessage(message: "could not reload page", category: MyLogger.log_category_ui_functionality)
            
        }
        
        // init 'reload' button functionality according to active webView protocol. Inform log when user can not reload page. If for any reason this action can not be executed, inform the log
                
    }
    
    private func initWebNavButtons(){
        
        previousPageButton.target = self
        
        previousPageButton.action = #selector(backButtonTapped(sender:))
        
        reloadPageButton.target = self
        
        reloadPageButton.action = #selector(reloadPageButtonTapped(sender:))
        
        // init the custom 'back' and 'reload' buttons for webView protocol
                
    }
    
    private func initWebViewDimens(){
        
        if (wkWebView != nil) {
            
            view.addSubview(wkWebView)
                                
            wkWebView.translatesAutoresizingMaskIntoConstraints = false
            
            let leadingContraint = wkWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            let trailingConstraint = wkWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            let topConstraint = wkWebView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0)
            let bottomConstraint = wkWebView.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor, constant: 0)
            
            view.addConstraints([leadingContraint, trailingConstraint, topConstraint, bottomConstraint])
            
        }
        
        if (webView != nil) {
            
            view.addSubview(webView)
                                
            webView.translatesAutoresizingMaskIntoConstraints = false
            
            let leadingContraint = webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
            let trailingConstraint = webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
            let topConstraint = webView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0)
            let bottomConstraint = webView.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor, constant: 0)
            
            view.addConstraints([leadingContraint, trailingConstraint, topConstraint, bottomConstraint])
            
            
            
        }
        
        // above code creates either a webView or wkWebView object inside the appointmentViewController with the following dimensions: left and right to screen borders, top below top layout guide, bottom above bottom toolbar (the toolbar that contains the custom webpage navigation buttons)
        
    }
    
    private func initAndCleanAppropriateWebViewWkWebView(){
        
        wkWebView = WKWebView()
        
        wkWebView.navigationDelegate = self
                        
        webView = nil
        
    }
    
    private func initAndCleanAppropriateWebViewWebView(){
        
        webView = UIWebView()
        
        wkWebView = nil
        
    }
    
    private func loadWebpage (uiWebView: UIWebView!, wkWebView: WKWebView!){
                        
        guard let url = URL(string: viewModel.webURLString) else {
                                    
            viewModel.logUrlInvalidMessage()
            
            return
            
        }
        
        print("\(viewModel.webURLString)")
        
        if uiWebView != nil {
            
            uiWebView.loadRequest(NSURLRequest(url: url) as URLRequest)
                        
        } else if wkWebView != nil {
            
            wkWebView.load(URLRequest(url: url))
            
        }
                
        // load webpage into currently active webView protocol (see AppointmentViewController comments for clarification)
        
    }
    
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        
        self.openMyMMDrawerControllerMenu(itemIndexPath: IndexPath(row: MyConstants.appointment_viewcontroller_index, section: 0))
        
        // show MenuViewController (see 'MyTypeExtensionFunctions.swift')
        
    }
    
    deinit {
        
        MyLogger.logMessage(message: "Deinitialised AppointmentViewController", category: MyLogger.log_category_info)

    }
        
}

import MMDrawerController
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak private var homeScrollView: UIScrollView!
    
    @IBOutlet weak private var mainText: UILabel!
    
    @IBOutlet weak var statusbarOverlapViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var business_hours_button: UIButton!
    
    // button tap action is initialised in storyboard (push to Hours Of Operation Viewcontroller)
    
    private var viewModel = HomeViewModel()
        
    // Direction lock enabled and horizontal and vertical indicators disabled in Main.storyboard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        MyConstants.currently_active_center_viewController = MyConstants.homeViewControllerIdentifier
        
        statusbarOverlapViewHeightConstraint.constant = MyUIConstants().statusbarOverlapViewHeightConstraint
        
        self.navigationController?.isNavigationBarHidden = true
                                
        initVCTexts()
                        
    }
    
     override func viewWillAppear(_ animated: Bool){
         
         super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        
        self.openMyMMDrawerControllerMenu(itemIndexPath: IndexPath(row: MyConstants.home_viewcontroller_index, section: 0))
        
        // show MenuViewController (see 'MyTypeExtensionFunctions.swift')
        
    }
    
    private func initVCTexts(){
        
        mainText.text = viewModel.startupText
        
        business_hours_button.setTitle(viewModel.business_hours_button_text, for: .normal)
        
    }
    
    /*
    
    - The above method generates an invisible label exclusively for UITesting purposes. The label is automatically (and invisible to the person running the UITests) populated with text when the most recently available data is loaded into the UI. This allows UITests to be aware of the moment when it can start pressing buttons and potentially perform other related operations, as within the app's functionality, app interaction is disabled up until the point where the most recently available data is fetched, saved an loaded into the UI.
    
    - The '#if DEBUG' conditional compilation flag allows this function to only be run in a debug environment, since it is unneccessary to include this function in the release build of the app
    
    */
    
    deinit {MyLogger.logMessage(message: "Deinitialised HomeViewController", category: MyLogger.log_category_info)}
    
}


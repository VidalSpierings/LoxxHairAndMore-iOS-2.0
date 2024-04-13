import MMDrawerController
import UIKit

class TariffsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
                                            
    private var viewModel = TariffsViewModel()
    
    private var isPricesForShortHairShown = true
    
    private var shortOrLongHairIndex = 1
    
    @IBOutlet weak var hairLengthButton: UIButton!
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak var pricesForText: UILabel!
        
    @IBOutlet weak var statusbarOverlapViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        MyConstants.currently_active_center_viewController = MyConstants.tariffsViewControllerIdentifier
        
        statusbarOverlapViewHeightConstraint.constant = MyUIConstants().statusbarOverlapViewHeightConstraint
        
        self.navigationController?.isNavigationBarHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        hairLengthButton.setTitle(viewModel.short_button_text, for: .normal)
        
        pricesForText.text = viewModel.prices_for_text
        
    }
    
    
    @IBAction private func hairLengthButtonTapped(_ sender: UIButton) {
        
        //set prices for long
        if isPricesForShortHairShown {
                        
            sender.setTitle(viewModel.long_button_text, for: UIControl.State.normal)
                                                                                        
            isPricesForShortHairShown = false
            
            shortOrLongHairIndex = 2
                        
            
        } else if (!isPricesForShortHairShown){
            
            //set prices for short
            
            sender.setTitle(NSLocalizedString(viewModel.short_button_text, comment: "Hair length type short"), for: UIControl.State.normal)
                                                                                                        
            isPricesForShortHairShown = true
            
            shortOrLongHairIndex = 1
                    
        }
        
        tableView.reloadData()
        
    }
    
    /*
    
    @IBAction private func hairLengthButtonTapped(_ sender: UIButton) {
        
        //set prices for long
        if isPricesForShortHairShown {
                        
            sender.setTitle(NSLocalizedString("long", comment: "Hair length type long"), for: UIControl.State.normal)
                                                                                        
            isPricesForShortHairShown = false
            
            shortOrLongHairIndex = 2
                        
            
        } else if (!isPricesForShortHairShown){
            
            //set prices for short
            
            sender.setTitle(NSLocalizedString("short", comment: "Hair length type short"), for: UIControl.State.normal)
                                                                                                        
            isPricesForShortHairShown = true
            
            shortOrLongHairIndex = 1
                    
        }
        
        tableView.reloadData()
        
    }
    
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tariffs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as? ServiceTableViewCell

        cell?.serviceLabel?.text = viewModel.tariffs[indexPath.row][0]
        cell?.priceLabel?.text = viewModel.tariffs[indexPath.row][shortOrLongHairIndex]

        return cell ?? tableView.dequeueReusableCell(withIdentifier: "nil", for: indexPath)
        
    }
    
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        
        self.openMyMMDrawerControllerMenu(itemIndexPath: IndexPath(row: MyConstants.tariffs_viewcontroller_index, section: 0))
        
        // show MenuViewController (see 'MyTypeExtensionFunctions.swift')
        
    }
    
    deinit {
        
        MyLogger.logMessage(message: "Deinitialised TariffsViewController", category: MyLogger.log_category_info)

    }
    
}

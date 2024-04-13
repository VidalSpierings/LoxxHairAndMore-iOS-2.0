import UIKit
import MessageUI
import MMDrawerController
import os

//TODO: WHEN FINISHED: CHECK IMPORTS

class InformationViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private var viewModel = InformationViewModel()
    
    @IBOutlet weak private var e_mail: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak private var loxxImage: UIImageView!
    
    @IBOutlet weak var showInMapButton: UIButton!
    
    @IBOutlet weak var statusbarOverlapViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    MyConstants.currently_active_center_viewController = MyConstants.informationViewControllerIdentifier
        
    statusbarOverlapViewHeightConstraint.constant = MyUIConstants().statusbarOverlapViewHeightConstraint
        
    self.navigationController?.isNavigationBarHidden = true
        
    localizeVCTexts()
        
    let tapGestureRecognizerImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(attemptOpenFacebookPage(gestureRecognizer:)))
        
    let tapGestureRecognizerEmail: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eMailTapped(gestureRecognizer:)))
        
    let tapGestureRecognizerShowInMapButton: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(attemptOpenInMap(gestureRecognizer:)))
                                                         
        loxxImage.isUserInteractionEnabled = true
        loxxImage.addGestureRecognizer(tapGestureRecognizerImage)
        
        e_mail.isUserInteractionEnabled = true
        e_mail.addGestureRecognizer(tapGestureRecognizerEmail)
                
        showInMapButton.addGestureRecognizer(tapGestureRecognizerShowInMapButton)
        
    }
    
    private func localizeVCTexts(){
        
        e_mail.text = viewModel.email
        address.text = viewModel.address
        showInMapButton.setTitle(viewModel.show_in_map_button_localized_text, for: .normal)
        
    }
    
    @objc private func attemptOpenInMap(gestureRecognizer: UITapGestureRecognizer) {
        
        //https://goo.gl/maps/q8u4yGbnD8NohXG8A
        //https://maps.apple.com/?address=Burgemeester_Brokxlaan_1708A,5041_SH_Tilburg,Nederland&auid=3974802239832522525&ll=51.561933,5.076350&lsp=9902&q=LOXXHairandMore&_ext=CjIKBQgEELABCgQIBRADCgQIBhBnCgQIChAACgQIUhABCgQIVRAQCgQIWRAECgUIpAEQARImKRzfKLRYx0lAMTitrUatRhRAOZq0ThB/yElAQT4WrkV5VRRAUAQ=
        
        guard let gMapsAppUrl = URL(string: "comgooglemapsurl://" + viewModel.gMapsURLString) else {return}
        guard let gMapsWebUrl = URL(string: viewModel.gMapsURLString) else {return}
        guard let aMapsUrl = URL(string: viewModel.aMapsURLString) else {return}

        
        attemptOpenService(url1: gMapsAppUrl, url2: gMapsWebUrl, url3: aMapsUrl, logMessage1: "Unable to find or open Google Maps", logMessage2: "Could not open Google Maps app and/or webpage", finalLogMessage: "Unable to open Google Maps app and/or webpage, and also unable to open Apple Maps", errorTitle: NSLocalizedString("cannot display page", comment: ""), errorMessage: NSLocalizedString("cannot display page explained", comment: ""))
        
    }
    
    @objc private func attemptOpenFacebookPage (gestureRecognizer: UITapGestureRecognizer){
                    
        guard let fbWebUrl = URL(string: viewModel.facebookURL) else {return}
        guard let fbAppUrlID = URL(string: "fb://profile/584487294978963") else {return}
        
        attemptOpenService(url1: fbAppUrlID, url2: fbWebUrl, url3: nil, logMessage1: "Facebook app was not found and/or unable to start", logMessage2: nil, finalLogMessage: "The Facebook app was not found and/or the app/webpage was unable to be opened", errorTitle: NSLocalizedString("cannot display page", comment: ""), errorMessage: NSLocalizedString("cannot display page explained", comment: ""))
        
    }

    @objc private func eMailTapped (gestureRecognizer: UITapGestureRecognizer){
    
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([viewModel.email])
        if MFMailComposeViewController.canSendMail() {
            
        self.present(mailComposeViewController, animated: true, completion: nil)
            
        } else {
            
            MyErrorAlertBuilder().displayStandardErrorAlert(logText: "Unable to send e-mails", logCategory: MyLogger.log_category_system_functionality, viewController: self, errorTitle: NSLocalizedString("send email error title", comment: ""), errorMessage: NSLocalizedString("send email error message", comment: ""))
            
        }
    }
    
    // IMPORTANT: Please note the following when testing e-mail sending functionalities whilst using the simulator (final sentence within the tutorial): https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
    
    
    private func configuredMailComposeVC() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([viewModel.email])
        
        return mailComposerVC
    }
    
    private func attemptOpenService(url1: URL, url2: URL, url3: URL?, logMessage1: String, logMessage2: String?, finalLogMessage: String, errorTitle: String, errorMessage: String){
                                
        if(UIApplication.shared.canOpenURL(url1)){
                                        
            UIApplication.shared.open(url1)
            
            /*
             
             code for version suport from iOS 10.0:
            
             if #available(iOS 10.0, *) {
                 
                 UIApplication.shared.open(url1)
                 
             } else {
                                                 
                 UIApplication.shared.openURL(url1)
                 
             }
            
            */

            
            // open address in Google Maps app if user has this app installed
            
        } else if (UIApplication.shared.canOpenURL(url2)){
                        
            print(logMessage1)
                        
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url2)
            } else {
                                
                UIApplication.shared.openURL(url2)
                
            }
            
            // if Google Maps application not found, attempt to open Address in Apple Maps
                        
        } else if (UIApplication.shared.canOpenURL(url3!)) {
                        
            // if, for whatever reason, Apple Maps application was not found, attempt to open Address in Google maps web page inside webbrowser
            
            print(logMessage2 ?? "")
                                    
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url3!)
                
            } else {
                                
                UIApplication.shared.openURL(url3!)
                
            }
                        
        } else {
            
            print("LAST")
            
            // if, for whatever reason, webpage cannot be opened, show Error Alert
                                    
            MyErrorAlertBuilder().displayStandardErrorAlert(logText: finalLogMessage, logCategory: MyLogger.log_category_error, viewController: self, errorTitle: errorTitle, errorMessage: errorMessage)
                        
        }
            
        }
    
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        
        self.openMyMMDrawerControllerMenu(itemIndexPath: IndexPath(row: MyConstants.information_viewcontroller_index, section: 0))
        
        // show MenuViewController (see 'MyTypeExtensionFunctions.swift')
        
    }
    
    deinit {MyLogger.logMessage(message: "Deinitialised InformationViewController", category: MyLogger.log_category_info)}
        
    }

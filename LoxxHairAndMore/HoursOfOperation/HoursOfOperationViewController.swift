import MMDrawerController

class HoursOfOperationViewController: UIViewController {
    
    @IBOutlet weak private var
                       monday_name_label,
                       monday_times_label,
                       
                       tuesday_name_label,
                       tuesday_time_label,
                       
                       wednesday_name_label,
                       wednesday_time_label,
                       
                       thursday_name_label,
                       thursday_time_label,
                       
                       friday_name_label,
                       friday_time_label,
                       
                       saturday_name_label,
                       saturday_time_label,
                       
                       sunday_name_label,
                       sunday_time_label,
                       
                       makeAppointmentText: UILabel!
        
    @IBOutlet weak private var callUsButton, onlineButton: UIButton!
                
    private var viewModel = HoursOfOperationViewModel()
    
    private var daysTextArray: [UILabel] = []
    
    private var timesTextArray: [UILabel] = []
    
    private var time: String = ""
    
    private var currentTime: String = ""

    private var currentLabel: UILabel = UILabel()
    
    
    @IBOutlet weak var statusbarOverlapViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        MyConstants.currently_active_center_viewController = MyConstants.hoursOfOperationViewControllerIdentifier
                
        statusbarOverlapViewHeightConstraint.constant = MyUIConstants().statusbarOverlapViewHeightConstraint
        
        self.navigationController?.isNavigationBarHidden = true
                
        daysTextArray = [monday_name_label, tuesday_name_label, wednesday_name_label, thursday_name_label, friday_name_label, saturday_name_label, sunday_name_label]
        
        timesTextArray = [monday_times_label, tuesday_time_label, wednesday_time_label, thursday_time_label, friday_time_label, saturday_time_label, sunday_time_label]
        
        /*
        
        // put all the business hours-related labels into arrays, so the appropriate names for the day of the week and appropriate
           opening hours can be set in a for loop
        
        */
                
        if (MyCallUtil().checkIfCallCapabilityAvailable()) {
            
            callUsButton.setTitle(viewModel.call_us_button_text, for: .normal)
            
            callUsButton.addTarget(self, action: #selector (callButtonTapped), for: .touchUpInside)
            
        } else {
            
            callUsButton.isHidden = true
            
        }
        
        /*
        
        // only show the call button if the device the application is run from has a calling capability. This for example ensures
           that the 'Call us' button won't be made visible if the user has an iPod or iPad, amongst other convenient use cases
        
        */
        
        initVCText()
        
    }
    
    private func initVCText(){
                
        onlineButton.setTitle(viewModel.online_button_text, for: .normal)
        
        makeAppointmentText.text = viewModel.make_an_appointment_text
        
        if timesTextArray.count == viewModel.business_hours.count && timesTextArray.count == viewModel.days_in_week_names.count {
            
            for index in 0..<timesTextArray.count {
                
                timesTextArray[index].text = viewModel.business_hours[index]
                
                daysTextArray[index].text = viewModel.days_in_week_names[index]
                
                setMiscBusinessHoursTypeIfNecessary(index: index)
            
            }
            
        } else {
            
            MyErrorAlertBuilder().displayStandardErrorAlert(logText: "Unable to get business hours: timesTextArray and business_hours array not same length", logCategory: MyLogger.log_category_error, viewController: self, errorTitle: NSLocalizedString("cant retrieve business hours title", comment: ""), errorMessage: NSLocalizedString("cant retrieve business hours description", comment: ""))
            
        }
        
        // attempt to load the most recent business hours data into the labels. If not possible, inform user by showing an error alert
    
}
    
    private func setMiscBusinessHoursTypeIfNecessary (index: Int){
        
        if viewModel.business_hours[index].lowercased() == "\(viewModel.closed) - \(viewModel.closed)".lowercased() {
            
            timesTextArray[index].text = viewModel.closed
            
        } else if viewModel.business_hours[index].lowercased() == "\(viewModel.opened_24_7) - \(viewModel.opened_24_7)".lowercased(){
        
            timesTextArray[index].text = viewModel.opened_24_7
                    
    }
        
    }
    
    private func initCallUsButton(){
        
        let stringFromModel = ""
        
        callUsButton.setTitle(stringFromModel, for: .normal)
        
        callUsButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        
    }
    
    private func assignCorrectStringsToLabels (listOfNames: [String], listOfTimes: [String]){
        
        for day in 0...listOfTimes.count {
            
            currentTime = listOfTimes[day]
            currentLabel = timesTextArray[day]
            
            daysTextArray[day].text = listOfNames[day]
            currentLabel.text = currentTime
            
            setMiscBusinessHoursTypeIfNecessary()

        }
        
    }
    
    private func setMiscBusinessHoursTypeIfNecessary(){
        
        if (currentTime.lowercased() == "\(viewModel.closed) - \(viewModel.closed)".lowercased()) {
            
            currentLabel.text = viewModel.closed
            
        } else if (currentTime.lowercased() == "\(viewModel.opened_24_7) - \(viewModel.opened_24_7)".lowercased()) {
            
            currentLabel.text = viewModel.opened_24_7
            
        }
        
    }
    
    @objc private func callButtonTapped(){
                
        guard let url = URL(string: "tel://\(viewModel.phone_number)") else {return}
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url)
                
            } else {
                
                UIApplication.shared.openURL(url)
                
            }
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url)
                
            } else {
                
                UIApplication.shared.openURL(url)
                
            }
    
    }
    
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        
        self.openMyMMDrawerControllerMenu(itemIndexPath: IndexPath(row: MyConstants.hours_of_operation_viewcontroller_index, section: 0))
        
        // show MenuViewController (see 'MyTypeExtensionFunctions.swift')
        
    }
    
    deinit {
        
        MyLogger.logMessage(message: "Deinitialised HoursOfOperationController", category: MyLogger.log_category_info)

    }
    
}

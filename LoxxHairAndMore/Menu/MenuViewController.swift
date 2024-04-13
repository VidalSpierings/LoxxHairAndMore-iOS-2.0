import MMDrawerController

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
        
    var cellEntries = MenuViewModel().cellEntries
    // no local menuViewModel variable created because the above istance is the only time something from the viewmodel needs to be called
    
    let dynamicViewBackgroundColor =
    UIColor(red: 1.00, green: 0.86, blue: 0.77, alpha: 1.00) | UIColor(red: 0.78, green: 0.67, blue: 0.58, alpha: 1.00)
    // RGB Light: 255, 220, 196 | RGB Dark: 198, 172, 147
    
    let dynamicTableViewAreaBackgroundColor = UIColor(red: 0.99, green: 0.93, blue: 0.87, alpha: 1.00) | UIColor(red: 0.80, green: 0.73, blue: 0.67, alpha: 1.00)
    // RGB Light: 253, 238, 223 | RGB Dark: 204, 186, 170
    
    // See 'MyCustomColorOperator' class for reference
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
                        
        view.backgroundColor = dynamicViewBackgroundColor
        tableView.backgroundColor = dynamicTableViewAreaBackgroundColor
        
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            
        let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MenuItemTableViewCell
                        
        myCell.menuItemLabel.text = cellEntries[indexPath.row].displayName
        
        myCell.menuItemLabel.font = UIFont.systemFont(ofSize: 21.0)
                                
        //TODO: NOT WORKING!!!!!
        
        return myCell
        
        // Create cell with custom text and font size
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for menuItem in tableView.visibleCells {
            
            menuItem.contentView.backgroundColor = dynamicTableViewAreaBackgroundColor
            
        }
                
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = dynamicViewBackgroundColor
        
        
                        
        if #available(iOS 13.0, *) {
            
            showMenuViewControllerPostiOS13(index: indexPath.row)
            
        } else {
            
            showMenuViewControllerPreiOS13(index: indexPath.row)
            
        }
        
    }
    
    @available(iOS 13.0, *)
     private func showMenuViewControllerPostiOS13(index: Int){
                                                     
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: cellEntries[index].identifier))!
            
        let navController = UINavigationController(rootViewController: viewController)
            
        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            
        sceneDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        sceneDelegate.centerContainer!.centerViewController = navController
            
        }
    
    private func showMenuViewControllerPreiOS13(index: Int){
                
        let viewController = (self.storyboard?.instantiateViewController(withIdentifier: cellEntries[index].identifier))!
        
        let navController = UINavigationController(rootViewController: viewController)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.centerContainer!.centerViewController = navController
        
    }

}

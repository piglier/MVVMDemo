import UIKit

// MARK: - View Controller

class MainViewController: UIViewController {
            
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // #1 - The UITableViewDataSource and
        // UITableViewDelegate protocols are
        // adopted in extensions.
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            
            if let destinationViewController = segue.destination as? DetailViewController
            {
//                let a = self.tableView.indexPath(for: <#T##UITableViewCell#>)
                let selectedIndexPathRow: Int = sender as! Int
//                let index = indexPath.row
                // #2 - The ViewModel is the app's de facto data source.
                // The ViewModel data for the currently-selected table
                // view cell representing a Messier object is passed to
                // a detail view controller via a segue.
                destinationViewController.messierViewModel = messierViewModel[selectedIndexPathRow]
            }
        }
        
    } // end func prepare

} // end class ViewController

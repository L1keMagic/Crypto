import Foundation
import UIKit

func spinner(tableView: UITableView) {
    let spinner = UIActivityIndicatorView()
    spinner.startAnimating()
    tableView.backgroundView = spinner
}

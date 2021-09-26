import UIKit

class HomeViewController: UIViewController{
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
        
        let searchBar = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchBar
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        spinner(tableView: tableView)
        
        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({ model in
                    // Number Formatter
                    let price = model.price_usd ?? 0
                    let formatter = HomeViewController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    
                    let iconUrl = URL(
                        string:
                            APICaller.shared.icons.filter({ icon in
                                icon.asset_id == model.asset_id
                            }).first?.url ?? "")
                    
                    return CryptoTableViewCellViewModel(
                        name: model.name ?? "N/A",
                        symbol: model.asset_id,
                        price: priceString ?? "N/A",
                        iconUrl: iconUrl
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        APICaller.Constants.assetsChosenCrypto = "\(viewModels[indexPath.row].symbol)/"
        self.navigationController?.show(DetailedViewController(), sender: nil)
    }
}

//extension HomeViewController: UISearchBarDelegate {
//    func searchBar() {
//        let searchBar: UISearchBar = UISearchBar()
//        searchBar.searchBarStyle = UISearchBar.Style.prominent
//        searchBar.placeholder = " Search..."
//        searchBar.sizeToFit()
//        searchBar.isTranslucent = false
//        searchBar.backgroundImage = UIImage()
//        searchBar.delegate = self
//        view.addSubview(searchBar)
//    }
//}

//extension HomeViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        if searchController.searchBar.text! == "" {
////            filtered = data
//        }
//        else {
//            viewModels = viewModels.filter  {$0.name.lowercased().contains(searchController.searchBar.text!.lowercased())}
//            }
//        self.tableView.reloadData()
//    }
//
//}

import UIKit

class DetailedViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ChosenCryptoTableViewCell.self, forCellReuseIdentifier: ChosenCryptoTableViewCell.identifier)
        return table
    }()
    
    private var data: [ChosenCrypto]?
    
    private var viewModels = [ChosenCryptoTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchData() {
        APICaller.shared.getChosenCrypto { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.setUpViewModels()
                }
                print("Success \(data)")
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    private func setUpViewModels() {
        guard let model = data else {
            return
        }
        viewModels = [
            ChosenCryptoTableViewCellModel(
                title: "Token name",
                value: model[0].asset_id
            ),
            ChosenCryptoTableViewCellModel(
                title: "Name",
                value: model[0].name
            ),
            ChosenCryptoTableViewCellModel(
                title: "Price",
                value: String(model[0].price_usd)
            )
        ]
        setTable()
    }
    
    private func setTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChosenCryptoTableViewCell.identifier,
            for: indexPath
        ) as? ChosenCryptoTableViewCell else { fatalError() }
        
        cell.configure(with:  viewModels[indexPath.row])
        return cell 
    }
    
}

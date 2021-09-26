import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let apiKey = "C081EEEF-35E2-47E3-9427-4524D35F6717"
        static let assetsEndPoint = "https://rest-sandbox.coinapi.io/v1/assets/"
        static let assetsIcons = "icons/55/"
        public static var assetsChosenCrypto = "doge/"
    }
    
    private init() {}
    
    public var icons: [Icon] = []
    
    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    
    
    // MARK: - Public
    public func getAllCryptoData(
        complition: @escaping (Result<[Crypto], Error>) -> Void
    ) {
        guard !icons.isEmpty else {
            whenReadyBlock = complition
            return
        }
        
        guard let url = URL(string: Constants.assetsEndPoint + "?apikey=" + Constants.apiKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                
                complition(.success(cryptos.sorted { first, second -> Bool in
                    return first.volume_1day_usd ?? 0 > second.volume_1day_usd ?? 0
                }))
            } catch { complition(.failure(error)) }
        }
        task.resume()
    }
    
    public func getAllIcons() {
        guard let url = URL(string: Constants.assetsEndPoint + Constants.assetsIcons + "?apikey=" + Constants.apiKey) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let complition = self?.whenReadyBlock {
                    self?.getAllCryptoData(complition: complition)
                }
            } catch { print(error) }
        }
        task.resume()
    }
    
    public func getChosenCrypto(
        complition: @escaping (Result<[ChosenCrypto], Error>) -> Void)
    {
        guard let url = URL(string: Constants.assetsEndPoint + Constants.assetsChosenCrypto + "?apikey=" + Constants.apiKey) else { return }
//        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode([ChosenCrypto].self, from: data)
                complition(.success(result))
            } catch { complition(.failure(error)) }
        }
        task.resume()
    }
}

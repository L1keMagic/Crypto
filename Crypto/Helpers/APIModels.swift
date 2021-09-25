import Foundation

struct Crypto: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let volume_1day_usd: Double?
    let id_icon: String?
}

struct Icon: Codable {
    let asset_id: String
    let url: String
}

struct ChosenCrypto: Codable {
    let asset_id: String
    let name: String
    let price_usd: Float
}

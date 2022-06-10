struct Good: Codable {
    let id: Int
    let name: String
    let weight: Double
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "good_id"
        case name = "good_name"
        case weight = "good_weight"
        case price = "good_price"
    }
    
    
}


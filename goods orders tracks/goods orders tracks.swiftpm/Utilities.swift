import SwiftUI

enum BaseURL: String {
    case base = "http://192.168.2.162:8085/"
}

enum EndPoints: String {
    case getOrdersWithGoods = "order/findOrders"
    case getOrderTracks = "order/findTracksByOrderId/"
    case getUsers = "user/findUsers"
    case updateGood = "good/updateGoodInfo"
    case addTrack = "track/addTrack"
    case addOrder = "order/addOrderWithTonsOfData"
    case deleteOrder = "order/deleteOrderById/"
    case deleteSpecificTrack = "track/deleteSpecificTrack"
    case updateOrder = "order/updateOrder"
    case updateUser = "user/updateUser"
}

enum HttpMethods: String {
    case GET, POST, PUT, DELETE
}

enum HttpErrors: Error {
    case badUrl, badResponse, decodingError, encodingError
}

enum HttpHeaders: String {
    case MIMETYPE = "Content-Type"
    case JSON = "application/json"
}

enum OrderStates: String {
    case ready = "待发货"
    case onTheWay = "已发货"
    case arrived = "已送达"
    static let allCases = ["待发货","已发货","已送达"]
}



enum GoodStates: String {
    case ready = "待发货"
    case onTheWay = "已发货"
    case arrived = "已送达"
}

enum Genders: String, CaseIterable {
    case male = "男"
    case female = "女"
}

func fetch<T: Codable> (url: URL) async throws -> [T] {
    let (data, response) = try await URLSession.shared.data(from: url)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw HttpErrors.badResponse
    }
    do {
        let object = try JSONDecoder().decode([T].self, from: data) 
        return object
    } catch {
        print(error)
        throw HttpErrors.decodingError
    }
}
func sendData<T: Codable> (url: URL, object: T, method: String?) async throws {
    var request = URLRequest(url: url)
    request.httpMethod = method    
    request.addValue(HttpHeaders.JSON.rawValue, forHTTPHeaderField: HttpHeaders.MIMETYPE.rawValue)
    do { 
        try request.httpBody = JSONEncoder().encode(object)
    } catch {
        print(error)
        throw(HttpErrors.encodingError)
    }
    let (_, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw HttpErrors.badResponse
    }
    
}

func sendData<T: Codable> (url: URL, object: T) async throws {
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethods.POST.rawValue            
    request.addValue(HttpHeaders.JSON.rawValue, forHTTPHeaderField: HttpHeaders.MIMETYPE.rawValue)
    do { 
        try request.httpBody = JSONEncoder().encode(object)
    } catch {
        print(error)
        throw(HttpErrors.encodingError)
    }
    let (_, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw HttpErrors.badResponse
    }
    
}

func deleteData<T: Codable> (url: URL, object: T) async throws {
    var request = URLRequest(url: url)
    request.httpMethod = HttpMethods.DELETE.rawValue       
    request.addValue(HttpHeaders.JSON.rawValue, forHTTPHeaderField: HttpHeaders.MIMETYPE.rawValue)
    do { 
        try request.httpBody = JSONEncoder().encode(object)
    } catch {
        print(error)
        throw(HttpErrors.encodingError)
    }
    let (_, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw HttpErrors.badResponse
    }
    
}


func sendData(url: URL, json: Data, method: String) async throws {
    var request = URLRequest(url: url)
    request.addValue(HttpHeaders.JSON.rawValue, forHTTPHeaderField: HttpHeaders.MIMETYPE.rawValue)
    request.httpBody = json
    request.httpMethod = method
    let (_, response) = try await URLSession.shared.data(for: request)
    print(response)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw HttpErrors.badResponse
    }
}


extension TimeInterval {
    func timeIntervalToIntToTimestamp() -> TimeInterval {
        return TimeInterval(integerLiteral:  
                                Int64(self*1000))
    }
}

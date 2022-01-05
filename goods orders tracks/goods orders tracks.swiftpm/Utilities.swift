import SwiftUI
import SwiftUICharts
enum BaseURL: String {
    case base = "http://192.168.2.162:8085/"
    
}

enum EndPoints: String {
    case getOrdersWithGoods = "order/findOrders"
    case getOrderTracks = "order/findTracksByOrderId/"
    case getUsers = "user/findUsers"
    case updateGood = "good/updateGood"
    case addTrack = "track/addTrack"
    case addOrder = "order/addOrderWithTonsOfData"
    case deleteOrder = "order/deleteOrderById/"
    case deleteSpecificTrack = "track/deleteSpecificTrack"
    case updateOrder = "order/updateOrder"
    case updateUser = "user/updateUser"
    case uploadExcel = "excel/importOrder"
}

enum MIMEType: String {
    case excel = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
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


func groupOrdersByState(ordersWithGoods: [OrderWithGood]) -> [String: Int] {
    var groupOrdersByState: [String: Int] = [:]
    
    ordersWithGoods.map { orderWithGood in
        if let _ =  groupOrdersByState[orderWithGood.orderState]  {
            groupOrdersByState[orderWithGood.orderState]! += 1
        } else {
            groupOrdersByState[orderWithGood.orderState] = 1
        }
    }
    
    
    return groupOrdersByState
}


func orderPieData(groupOrdersByState: [String: Int]) -> PieChartData {

    var dataPoints: [PieChartDataPoint] = []
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["待发货"] ?? 0), description: "待发货", colour: .red, label: .icon(systemName: "externaldrive.connected.to.line.below", colour: .white, size: 30)))
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["已发货"] ?? 0), description: "已发货", colour: .yellow, label: .icon(systemName: "airplane.departure", colour: .white, size: 30)))
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["已送达"] ?? 0), description: "已送达", colour: .green, label: .icon(systemName: "checkmark.icloud", colour: .white, size: 30)))
    
    let data = PieDataSet(dataPoints: dataPoints, legendTitle: "Data")
    
    return PieChartData(dataSets: data, metadata: ChartMetadata(title: "订单分析", subtitle: "对所有订单的发货状态进行统计"), chartStyle: PieChartStyle(infoBoxPlacement: .header))
}

func orderDoughnutData(groupOrdersByState: [String: Int]) -> DoughnutChartData {

    var dataPoints: [PieChartDataPoint] = []
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["待发货"] ?? 0), description: "待发货", colour: .red, label: .icon(systemName: "externaldrive.connected.to.line.below", colour: .white, size: 30)))
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["已发货"] ?? 0), description: "已发货", colour: .yellow, label: .icon(systemName: "airplane.departure", colour: .white, size: 30)))
    dataPoints.append(PieChartDataPoint(value: Double(groupOrdersByState["已送达"] ?? 0), description: "已送达", colour: .green, label: .icon(systemName: "checkmark.icloud", colour: .white, size: 30)))
    
    let data = PieDataSet(dataPoints: dataPoints, legendTitle: "Data")

    return DoughnutChartData(dataSets: data, metadata: ChartMetadata(title: "订单分析", subtitle: "对所有订单的发货状态进行统计"), chartStyle: DoughnutChartStyle(infoBoxPlacement: .header), noDataText: Text("Oops, seems there's no data!"))
}




extension TimeInterval {
    func timeIntervalToIntToTimestamp() -> TimeInterval {
        return TimeInterval(integerLiteral:  
                                Int64(self*1000))
    }
}


func createBody(fileUrl: URL, boundary: String) throws -> Data {
    var body = Data()
    body.appendBoundary(boundary)
    body.appendDisposition(fileUrl.lastPathComponent)
    body.appendMIMEType(MIMEType.excel.rawValue)
    
    fileUrl.startAccessingSecurityScopedResource()
    let fileData = try Data(contentsOf: fileUrl)
    fileUrl.stopAccessingSecurityScopedResource()
    body.append(fileData)
    body.appendEndBoundary(boundary)
    return body
}

func uploadFile(fileUrl: URL, webUrl: URL) async throws {
    let boundary = UUID().uuidString
    var request = URLRequest(url: webUrl)
    request.httpMethod = "POST"
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.httpBody = try createBody(fileUrl: fileUrl, boundary: boundary)
    request.setValue(String(request.httpBody?.count ?? 0), forHTTPHeaderField: "Content-Length")
    print(request.httpBody?.count ?? "Unknown body!")
    let (data, response) = try await URLSession.shared.data(for: request)
    print((response as? HTTPURLResponse)?.statusCode ?? "?")
}

let lineBreak = "\r\n"


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    mutating func appendDisposition(_ filename: String) {
        self.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\(lineBreak)")
    }
    mutating func appendBoundary(_ boundary: String) {
        self.append("--\(boundary + lineBreak)")
    }
    mutating func appendEndBoundary(_ boundary: String) {
        self.append("\(lineBreak)--\(boundary)--\(lineBreak)")
    }
    mutating func appendMIMEType(_ mimeType: String) {
        self.append("Content-Type: \(mimeType + lineBreak + lineBreak)")
    }
}

import SwiftUI
final class TracksViewModel: ObservableObject {
    @Published var tracks: [Track] = []
    
    @MainActor
    func fetchTracks(orderId: Int) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.getOrderTracks.rawValue + orderId.description) else {
            throw HttpErrors.badUrl
        }
        tracks = try await fetch(url: url)
        tracks = tracks.sorted() { $0.currentTime > $1.currentTime }
//        print(tracks)
    }
    
    func addTrack(track: Track) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.addTrack.rawValue) else {
            throw HttpErrors.badUrl
        }
        try await sendData(url: url, object: track)
    }
    
    func deleteTrack(index: Int) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.deleteSpecificTrack.rawValue) else {
            throw HttpErrors.badUrl
        }
        try await deleteData(url: url, object: tracks[index])
    }
    
    
}

import SwiftUI

struct AddTrackView: View {
    let orderId: Int
    @State private var currentLocation: String = ""
    @State private var currentTime: Date = Date()
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var tracksViewModel: TracksViewModel
    var body: some View {
        VStack {
            Form {
                Section(
                    header: Text("当前位置")
                ){
                    TextField("位置", text: $currentLocation)
                }
                
                Section(header: Text("当前时间")) {
                    HStack(spacing: 0) {
                        Image(systemName: "clock")
                        DatePicker("", selection: $currentTime)
                        
                    }
                }
                Button { 
                    Task {
                        try await tracksViewModel.addTrack(track: Track(orderId: orderId, currentLocation: currentLocation, currentTime: currentTime.timeIntervalSince1970.timeIntervalToIntToTimestamp()))
                        try await tracksViewModel.fetchTracks(orderId: orderId)
                    }
                    dismiss()
                } label: { 
                    Text("提交")
                }
                
            }
            
        }
        
    }
}

struct AddTrackView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrackView(orderId: 1)
    }
}

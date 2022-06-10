import SwiftUI

struct TrackDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tracksViewModel: TracksViewModel
    @State private var newLocation: String = ""
    @State private var newTime: Date = Date()
    let formatter: DateFormatter
    @Binding var index: Int 
    @State private var orderId: Int = 0
    var body: some View {
        VStack {
            List {
                Section(header: Text("当前路径")) {
                    HStack {
                        Text("位置")
                        Spacer()
                        Text(tracksViewModel.tracks[index].currentLocation)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                    }
                    HStack {
                        Text("时间")
                        Spacer()
                        Text(formatter.string(from: (Date(timeIntervalSince1970:  tracksViewModel.tracks[index].currentTime / 1000))))
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                    }
                    if index != tracksViewModel.tracks.endIndex - 1 {
                        
                        Button { 
                            orderId = tracksViewModel.tracks[index].orderId
                            Task {
                                try await tracksViewModel.deleteTrack(index: index)
                                try await tracksViewModel.fetchTracks(orderId: orderId)
                            }
                            dismiss()
                        } label: { 
                            Text("删除当前路径")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.red)
                        }
                    
                    }
                }
                
                
                Section(header: Text("更改路径")) {
                    TextField("New Location", text: $newLocation)
                    DatePicker("时间", selection: $newTime)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button { 
                        orderId = tracksViewModel.tracks[index].orderId
                        Task {
                            try await tracksViewModel.deleteTrack(index: index)
                            try await tracksViewModel.addTrack(track: Track(orderId: orderId, currentLocation: newLocation, currentTime: newTime.timeIntervalSince1970.timeIntervalToIntToTimestamp()))
                            try await tracksViewModel.fetchTracks(orderId: orderId)
                        }
                        dismiss()
                    } label: { 
                        Text("提交更新")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
                .onAppear { 
                    print("loaded details")
                    newLocation = tracksViewModel.tracks[index].currentLocation
                    newTime = Date(timeIntervalSince1970: tracksViewModel.tracks[index].currentTime / 1000)
                }
            }
            
            
                Button { 
                    dismiss()
                } label: { 
                    Text("返回")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.accentColor)
                        .padding(.bottom, 19)
                        .padding(.top, 14)
                }
                
        }
        
        
    }
}

//struct TrackDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrackDetailView()
//    }
//}

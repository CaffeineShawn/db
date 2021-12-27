import SwiftUI

struct TrackView: View {
    let orderId: Int
    @EnvironmentObject var tracksViewModel: TracksViewModel
    @State private var selectedIndex: Int = 0
    var dateFormatter = DateFormatter()
    @State private var showingTrackDetailView = false
    @State private var showingAddTrackView = false
    init(orderId: Int) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")

        self.orderId = orderId
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            ForEach(0..<tracksViewModel.tracks.count, id: \.self) { index in
                TrackCellView(time: dateFormatter.string(from: Date(timeIntervalSince1970:  tracksViewModel.tracks[index].currentTime / 1000)), location: tracksViewModel.tracks[index].currentLocation, isFirst: index == 0  , isLast: index == tracksViewModel.tracks.count - 1)
                    
                    .onTapGesture { 
                        selectedIndex = index
                        print(selectedIndex)
                        showingTrackDetailView.toggle()
                        
                    }
                    .sheet(isPresented: $showingTrackDetailView) {  
                        TrackDetailView(formatter: dateFormatter, index: $selectedIndex)
                            .environmentObject(tracksViewModel)
                    }
                    
                    
                
                    .padding(.leading, 10)
                    
            }
            
            
        }
        
        
        .sheet(isPresented: $showingAddTrackView, content: { 
            AddTrackView(orderId: orderId)
                .environmentObject(tracksViewModel)
        })
        .toolbar(content: { 
            ToolbarItem(placement: .automatic) { 
                Button { 
                    showingAddTrackView.toggle()
                } label: { 
                    Text("Add Track")
                }
                
            }
        })
        .onAppear {
            Task {
                try await tracksViewModel.fetchTracks(orderId: orderId)
            }
        }
        
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(orderId: 1)
            .environmentObject(TracksViewModel())
//            .previewLayout(.sizeThatFits)
    }
}

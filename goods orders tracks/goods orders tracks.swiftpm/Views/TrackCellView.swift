import SwiftUI

struct TrackCellView: View {
    let time: String
    let location: String
    let isFirst: Bool 
    let isLast: Bool
    
    var body: some View {
        HStack  {
            Text(time)
                .font(.callout)
                .frame(width: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 8,height: 50)
                            .foregroundColor(Color.accentColor.opacity(0.2))
                            .opacity(isFirst ? 0 : 1)
                        Rectangle()
                            .frame(width: 8,height: 50)
                            .foregroundColor(Color.accentColor.opacity(0.2)).opacity(isLast ? 0 : 1)
                    
                    }
                    Circle()
                        .foregroundColor(.accentColor.opacity(0.3))
                        .frame(width: 30, height: 30)
                    Circle()
                        .foregroundColor(.accentColor.opacity(0.7))
                        .frame(width: 20, height: 20)
                }
            Spacer(minLength: 20)
//            Rectangle()
//                .frame(width: 10, height: 40)
//                .opacity(0)
            HStack {
                
                Text(location)
                    .padding(8)
                    
                Spacer()
            }
            .background(
                Color.gray.opacity(0.2),
                
                in: RoundedRectangle(cornerRadius: 8)
            )
            
        }
        .padding(.trailing, 10)
        
        
//        .padding(.horizontal)
    }
}

struct TrackCellView_Previews: PreviewProvider {
    static var previews: some View {
        TrackCellView(time: "Jan 20, 2021", location: "天安门广场", isFirst: true, isLast: false)
    }
}

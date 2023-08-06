import SwiftUI

struct OutputFile: View {
    @EnvironmentObject var sharedData: SharedData
    //    @Published var street: String = ""
    //    @Published var city: String = ""
    //    @Published var app: String = ""
    //    @Published var country: String = ""
    //    @Published var zip: String = ""
    var body: some View {
        VStack{
            HStack {
                if let url = sharedData.imageUrl {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable().frame(width: 250, height: 250)
                        case .failure(_):
                            Text("Failed to load image")
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("No image to display")
                }
            }
            HStack{
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    Text("Recipient:")
                        .font(.headline)
                    Text(sharedData.street)
                    Text("\(sharedData.city), \(sharedData.country) \(sharedData.zip)")
                    Spacer()
                    HStack {
                        Spacer()
                    }
                    .padding()
                }
                .padding()
                .frame(width: 250, height: 250)
                .background(Color.white)
                .border(Color.gray, width: 2)
            }
        }
    }
}


struct OutputFile_Previews: PreviewProvider {
    static var previews: some View {
        let sharedData = SharedData()
        // If you have a specific URL you want to use for previewing, uncomment the following line and replace "http://example.com/image.jpg" with your URL.
        // sharedData.imageUrl = URL(string: "http://example.com/image.jpg")
        
        return OutputFile()
            .environmentObject(sharedData)
    }
}

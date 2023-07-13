import Foundation
import SwiftUI
import UIKit

struct GenerateView: View {
    @State private var description: String = ""
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var imageUrl: URL?
    @State private var showingAlert = false
    @State private var selectedColor: Color = .yellow
    @State private var rgbColor: String = ""


    var body: some View {
        VStack {
            VStack {
                ColorPicker("Select a color", selection: $selectedColor)
                    .padding()
                
                TextField("Add description", text: $description)
                    .padding()
                
                Button("Generate an image") {
                    let rgbColor = selectedColor.toRGB()
                    ApiService().postRequest(description: self.description, color: rgbColor) { result in
                        self.imageUrl = URL(string: result)
                        viewRouter.currentPage = .Generate
                    }
                    
                }
                Button("Download an image") {
                    downloadImage()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Image Downloaded"), message: Text("Image has been saved to your Photos."), dismissButton: .default(Text("OK")))
                }
                
                if let url = imageUrl {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 400, height: 400)
                }
            }
            .padding()
        }
    }

    func downloadImage() {
        guard let url = self.imageUrl else {
            return
        }
        // Comment this out for SwiftUI previews
        /*
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            if let image = UIImage(data: data) {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                self.showingAlert = true
            }
        }
        task.resume()
        */
    }
}

extension Color {
        func toRGB() -> String {
            let uiColor = UIColor(self)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0

            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            let rgbString = "rgb(\(Int(red * 255)),\(Int(green * 255)),\(Int(blue * 255)))"
            return rgbString
        }
    }

struct GenerateView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateView().environmentObject(ViewRouter())
    }
}

import Foundation
import SwiftUI
import UIKit

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200, height: 40)
            .background(Color("purple"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct GenerateView: View {
    @State private var description: String = ""
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var imageUrl: URL?
    @State private var showingAlert = false
    @State private var selectedColor: Color = .yellow
    @State private var rgbColor: String = ""
    @State private var selectedOption: String = "Retro"
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    @State private var buttonScale: CGFloat = 1.0

    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        Image("Color")
                            .resizable()
                            .frame(width: 24, height: 24)

                        Text("Color")
                    }

                    ColorPicker("Select a color", selection: $selectedColor)
                        .padding()
                }

                HStack {
                    VStack{
                        Image("Style")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Style")
                    }
                    Picker("Select an option", selection: $selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .foregroundColor(.gray)
                        }
                    }
                    //.pickerStyle(MenuPickerStyle())
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack{
                    Image("Write")
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("Add description", text: $description)
                        .padding()
                }

                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        buttonScale = 0.9
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            buttonScale = 1.0
                        }
                    }

                    let rgbColor = selectedColor.toRGB()
                    ApiService().postRequest(description: description, color: rgbColor, style: selectedOption) { result in
                        self.imageUrl = URL(string: result)
                    }
                }) {
                    Text("Generate")
                }
                .buttonStyle(BlueButton())
                .scaleEffect(buttonScale)

                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Image Downloaded"), message: Text("Image has been saved to your Photos."), dismissButton: .default(Text("OK")))
                }

                if let url = imageUrl {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }.frame(width: 250, height: 250)
                }
            }
            .padding()
        }
    }

    /*
    func downloadImage() {
        guard let url = self.imageUrl else {
            return
        }

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

    }
     */

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

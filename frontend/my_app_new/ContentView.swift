import SwiftUI
import PythonKit
import UIKit // Add this import for UIKit

class SharedData: ObservableObject {
    @Published var description: String = ""
    @Published var selectedColor: Color = .yellow
    @Published var selectedOption: String = "Retro"
    @Published var imageUrl: URL? = nil
    @Published var street: String = ""
    @Published var city: String = ""
    @Published var app: String = ""
    @Published var country: String = ""
    @Published var zip: String = ""
}

struct ContentView: View {
    @State private var selectedPage = 0
    @StateObject private var sharedData = SharedData()
    let pageCount = 3
    
    @State private var generatedImage: UIImage? = nil
    @State private var showingAlert = false // Add this state
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Gray")
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        
                        Spacer()
                        PageView(selection: $selectedPage, views: [
                            AnyView(PageOneView().environmentObject(sharedData)),
                            AnyView(PageTwoView().environmentObject(sharedData)),
                            AnyView(PageThreeView().environmentObject(sharedData))
                        ])
                            .frame(height: 500)
                        
                        Spacer()
                        HStack {
                            Button(action: {
                                // Handle back action
                                if selectedPage > 0 {
                                    selectedPage -= 1
                                }
                            }) {
                                Image("Back")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }

                            Spacer()
                                .frame(width: 60)

                            CustomPageControl(numberOfPages: pageCount, currentPage: $selectedPage)

                            Spacer()
                                .frame(width: 60)

                            Button(action: {
                                // Handle next action
                                if selectedPage < pageCount - 1 {
                                    selectedPage += 1
                                }
                            }) {
                                Image("Next")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(40)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}


struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .bold()
            .padding()
            .frame(width: 150, height: 40)
            .background(Color("Button"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
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

struct CustomPageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int {
        didSet {
            withAnimation {
                currentPage = currentPage
            }
        }
    }
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.indigo : Color.gray)
                    .frame(width: index == currentPage ? 14 : 10, height: index == currentPage ? 14 : 10)
                    .onTapGesture {
                        currentPage = index
                    }
            }
        }
    }
}

struct PageView: View {
    @Binding var selection: Int
    var views: [AnyView]
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(views.indices, id: \.self) { index in
                views[index].tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Removes the default page indicator
    }
}

struct PageOneView: View {
    @EnvironmentObject var sharedData: SharedData
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    
    var body: some View {
            VStack(spacing: 15) {
                
                HStack(spacing: -10) {
                    VStack(alignment: .center) {
                        Text("Personalize the front page")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color.white)
        
                    }
                }
                .frame(width: 260, height: 30)
                .background(Color("Button"))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                
                HStack(spacing: -10) {
                    VStack {
                        Image("Color")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    ColorPicker("Select a color", selection: $sharedData.selectedColor)
                        .padding(15)
                        .foregroundColor(Color("InputText"))
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack {
                    VStack {
                        Image("Style")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    Picker("Select an option", selection: $sharedData.selectedOption) {
                        ForEach(options, id: \.self) { option in
                            Text(option).accentColor(.black)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(-15)

                    Spacer()
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack {
                    VStack {
                        Image("Description")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("Add description", text: $sharedData.description)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                

                HStack {
                    VStack {
                        Image("Check1")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    Text("All fields are required")
                        .foregroundColor(Color("Button"))
                        .font(.system(size: 12))
                }
            }
    }
}



struct PageTwoView: View {
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
            VStack(spacing: 15) {
                HStack(spacing: -10) {
                    VStack(alignment: .center) {
                        Text("Personalize the back page")
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(Color.white)
        
                    }
                }
                .frame(width: 260, height: 30)
                .background(Color("Button"))
                .clipShape(RoundedRectangle(cornerRadius: 20))


                HStack {
                    VStack {
                        Image("House")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("Street Address", text: $sharedData.street)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

//                HStack {
//                    VStack {
//                        Image("City")
//                            .resizable()
//                            .frame(width: 11, height: 25)
//                    }
//                    .frame(width: 50, height: 50, alignment: .center)
//
//                    TextField("App, suite, etc (optional)", text: $sharedData.app)
//                        .padding(-2)
//                }
//                .frame(width: 350, height: 55)
//                .background(Color.init(white: 1.0))
//                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                HStack {
                    VStack {
                        Image("City1")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("City", text: $sharedData.city)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                HStack {
                    VStack {
                        Image("Globe")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("Country", text: $sharedData.country)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                HStack {
                    VStack {
                        Image("Mail")
                            .resizable()
                            .frame(width: 24, height: 20)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("ZIP / Postcode", text: $sharedData.zip)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                
                HStack {
                    VStack {
                        Image("Check")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    Text("All fields are optional")
                        .foregroundColor(Color("Button"))
                        .font(.system(size: 12))
                    
                }
            }
        
    }
}


struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    @State var placeholderText: String = "Dear Daiana, I hope..."

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.delegate = context.coordinator

        // Setup placeholder
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text == "" {
            uiView.text = placeholderText
            uiView.textColor = UIColor.lightGray
        } else {
            uiView.text = text
            uiView.textColor = UIColor.black
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, UITextViewDelegate {
        var parent: MultilineTextView

        init(_ parent: MultilineTextView) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholderText
                textView.textColor = UIColor.lightGray
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}


struct PageThreeView: View {
    @State private var message: String = ""
    @State private var buttonScale: CGFloat = 1.0
    @State private var showingAlert = false
    @EnvironmentObject var sharedData: SharedData
    @State private var navigateToOutputFile = false
    @State private var startActio1: Bool = false
    
        var body: some View {
            VStack(spacing: 15) {
//                HStack(spacing: -10) {
//                    VStack(alignment: .center) {
//                        Text("Write a message")
//                            .font(.system(size: 20))
//                            .bold()
//                            .foregroundColor(Color.white)
//
//                    }
//                }
//                .frame(width: 190, height: 30)
//                .background(Color("Button"))
//                .clipShape(RoundedRectangle(cornerRadius: 15))
    
//                HStack {
//                    MultilineTextView(text: $message)
//                        .frame(width: 350, height: 150) // Modify height as needed
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Button"), lineWidth: 1.5))
//                }
    
//                HStack {
//                    VStack {
//                        Image("Check1")
//                            .resizable()
//                            .frame(width: 15, height: 15)
//                    }
//                    Text("All fields are required")
//                        .foregroundColor(Color("Button"))
//                        .font(.system(size: 12))
//                }
    
                HStack {
                    Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        buttonScale = 0.9
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            buttonScale = 1.0
                                        }
                                    }

                        let rgbColor = sharedData.selectedColor.toRGB()
                                                ApiService().postRequest(description: sharedData.description, color: rgbColor, style: sharedData.selectedOption) { result in
                                                    self.sharedData.imageUrl = URL(string: result)
                                                    self.startActio1 = true
                                                }
                        
                                }) {
                                    Text("Generate")
                                }
                                .buttonStyle(BlueButton())
                                .scaleEffect(buttonScale)

                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Image Downloaded"), message: Text("Image has been saved to your Photos."), dismissButton: .default(Text("OK")))
                                }

//                                if let url = imageUrl {
//                                    AsyncImage(url: url) { image in
//                                        image.resizable()
//                                    } placeholder: {
//                                        ProgressView()
//                                    }.frame(width: 250, height: 250)
//                                }
                                
                                NavigationLink(
                                    destination: OutputFile().environmentObject(sharedData), // Replace with the view you want to navigate to
                                    isActive: $startActio1,
                                    label: { EmptyView() }
                                )
                                .navigationTitle("") // Empty navigation title to hide the default back button text
                                .hidden()
                            }
            }
        }
    }
       



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PageOneView_Previews: PreviewProvider {
    static var previews: some View {
        PageOneView().environmentObject(SharedData())
    }
}

struct PageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        PageTwoView().environmentObject(SharedData())
    }
}

struct PageThreeView_Previews: PreviewProvider {
    static var previews: some View {
            let sharedData = SharedData()
            
            return PageThreeView()
                .environmentObject(sharedData)
        }
}

struct PostcardCardView: View {
    var body: some View {
        OutputFile()
        
    }
}

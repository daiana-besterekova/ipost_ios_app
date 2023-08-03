import SwiftUI
import PythonKit

struct ContentView: View {
    @State private var selectedPage = 0
    let pageCount = 3
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            GeometryReader { geometry in
                VStack(alignment: .center) {
                    
//                    HStack {
//                        Spacer()
//                        Button(action: {
//                            // Handle skip action
//                        }) {
//                            Text("Skip")
//                                .padding()
//                        }
//                    }
//                    .padding()
                    
                    Spacer()
                    PageView(selection: $selectedPage, views: [AnyView(PageOneView()), AnyView(PageTwoView()), AnyView(PageThreeView())])
                    
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
        .tabViewStyle(PageTabViewStyle())
    }
}

struct PageOneView: View {
    @State private var description: String = ""
    @State private var selectedColor: Color = .yellow
    @State private var selectedOption: String = "Retro"
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
            VStack(spacing: 15) {
//                HStack(){
//                    Text("Customize")
//                        .font(.title)
//                        //.fontWeight(.bold)
//                        .foregroundColor(Color("Button"))
//
//                }
                //.padding()

                HStack(spacing: -10) {
                    VStack {
                        Image("Color")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    ColorPicker("Select a color", selection: $selectedColor)
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

                    Picker("Select an option", selection: $selectedOption) {
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

                    TextField("Add description", text: $description)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                // Your button and image code here (commented out for clarity)
            }

             // Spacer to center the content vertically
        
        
    }
}

//                Button(action: {
//                    withAnimation(.easeInOut(duration: 0.2)) {
//                        buttonScale = 0.9
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        withAnimation(.easeInOut(duration: 0.2)) {
//                            buttonScale = 1.0
//                        }
//                    }
//
//                    let rgbColor = selectedColor.toRGB()
//                    ApiService().postRequest(description: description, color: rgbColor, style: selectedOption) { result in
//                        self.imageUrl = URL(string: result)
//                    }
//                }) {
//                    Text("Generate")
//                }
//                .buttonStyle(BlueButton())
//                .scaleEffect(buttonScale)
//
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("Image Downloaded"), message: Text("Image has been saved to your Photos."), dismissButton: .default(Text("OK")))
//                }
//
//                if let url = imageUrl {
//                    AsyncImage(url: url) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }.frame(width: 250, height: 250)
//                }


struct PageTwoView: View {
    @State private var description: String = ""
    @State private var selectedColor: Color = .yellow
    @State private var selectedOption: String = "Retro"
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
            VStack(spacing: 15) {
                HStack {
                    VStack {
                        Image("House")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("Street Address", text: $description)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                HStack {
                    VStack {
                        Image("City")
                            .resizable()
                            .frame(width: 11, height: 25)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("App, suite, etc (optional)", text: $description)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                HStack {
                    VStack {
                        Image("City1")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 50, height: 50, alignment: .center)

                    TextField("City", text: $description)
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

                    TextField("Country", text: $description)
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

                    TextField("ZIP / Postcode", text: $description)
                        .padding(-2)
                }
                .frame(width: 350, height: 55)
                .background(Color.init(white: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                // Your button and image code here (commented out for clarity)
            }

             // Spacer to center the content vertically
        
        
    }
}

import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    @State var placeholderText: String = "Write your message"

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        textView.font = UIFont.systemFont(ofSize: 16)
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
    @State private var selectedColor: Color = .yellow
    @State private var selectedOption: String = "Retro"
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    @State private var buttonScale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack {
                    Image("Message")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }
                
                .frame(width: 50, height: 50, alignment: .center)

                MultilineTextView(text: $message)
                    .frame(width: 300, height: 100) // Modify height as needed
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("Button"), lineWidth: 1.5))
            }

            HStack{
                VStack {
                    Button("Generate a message") {
                        // Add your action here
                        print("Button tapped!")
                    }
                    .padding()
                }
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
        PageOneView()
    }
}

struct PageTwoView_Previews: PreviewProvider {
    static var previews: some View {
        PageTwoView()
    }
}

struct PageThreeView_Previews: PreviewProvider {
    static var previews: some View {
        PageThreeView()
    }
}




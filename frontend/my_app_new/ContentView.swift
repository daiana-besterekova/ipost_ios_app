import SwiftUI
import PythonKit
import UIKit 

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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PostcardCardView: View {
    var body: some View {
        OutputFile()
        
    }
}

import SwiftUI

struct TestView: View {
    @State private var selectedImage = 0
    let images = ["Image 1", "Image 2", "Image 3", "Image 4"] // Replace these with the actual names of your images

    var body: some View {
        TabView(selection: $selectedImage) {
            ForEach(images.indices, id: \.self) { index in
                Image(images[index])
                    .resizable()
                    .scaledToFit()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear {
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            if selectedImage < images.count - 1 {
                selectedImage += 1
            } else {
                selectedImage = 0
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

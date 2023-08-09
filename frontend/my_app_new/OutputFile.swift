import SwiftUI

struct OutputFile: View {
    @EnvironmentObject var sharedData: SharedData
    @State private var isSharing = false
    @State private var pdfURL: URL? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Your postcard is ready!")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(width: 260, height: 40)
            .background(Color("Button"))
            .clipShape(RoundedRectangle(cornerRadius: 20))

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

            HStack {
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

            HStack {
                Button("Save and Share as PDF") {
                    saveAndShareAsPDF()
                }
                .buttonStyle(BlueButton())
            }
        }
        .sheet(isPresented: $isSharing, content: {
            ActivityView(activityItems: [pdfURL!], applicationActivities: nil)
        })
    }

    func saveAndShareAsPDF() {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 250, height: 500))

        let pdfData = pdfRenderer.pdfData { context in
            context.beginPage()
            let frontImage = renderFrontImage()
            let backImage = renderBackImage()

            frontImage.draw(in: CGRect(x: 0, y: 0, width: 250, height: 250))
            backImage.draw(in: CGRect(x: 0, y: 250, width: 250, height: 250))
        }

        // Save to document directory
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        pdfURL = documentsPath.appendingPathComponent("postcard.pdf")

        do {
            try pdfData.write(to: pdfURL!)
            print("PDF saved to \(pdfURL!)")
            isSharing = true
        } catch {
            print("An error occurred while saving the PDF: \(error)")
        }
    }

    func renderFrontImage() -> UIImage {
        // Implement the logic to render or obtain the front image of the postcard.
        return UIImage() // Replace with actual logic
    }

    func renderBackImage() -> UIImage {
        // Implement the logic to render or obtain the back image of the postcard.
        return UIImage() // Replace with actual logic
    }
}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}

struct OutputFile_Previews: PreviewProvider {
    static var previews: some View {
        let sharedData = SharedData()
        return OutputFile().environmentObject(sharedData)
    }
}

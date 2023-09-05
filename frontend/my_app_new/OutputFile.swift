import SwiftUI

struct OutputFile: View {
    @EnvironmentObject var sharedData: SharedData
    @State private var isSharing = false
    @State private var pdfURL: URL? = nil
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Your postcard is ready!")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .bold()
                    .foregroundColor(Color.white)
            }
            .frame(width: 260, height: 40)
            .background(Color("Button"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
            HStack {
                ZStack(alignment: .leading) {
                    if let url = sharedData.imageUrl {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .frame(width: 230, height: 230)
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
                
                .frame(width: 350, height: 250)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(.gray)
                )
                .cornerRadius(15)
            }
            
            
            
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        Text("Recipient:")
                            .font(.headline)
                    }
                    .padding(.leading, 20)
                    Text(sharedData.street)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.leading, 20)
                    Text("\(sharedData.city), \(sharedData.country) \(sharedData.zip)")
                        .font(.system(size: 16, weight: .medium))
                        .padding(.leading, 20)
                    Spacer()
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("Love you, miss you")
                        //.font()
                            .italic()
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 20)
                }
                .padding(20)
                .frame(width: 350, height: 250)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.gray)
                    }
                )
                .cornerRadius(15)
            }
            
            Spacer()
            HStack {
                Button("Save and Share as PDF") {
                    saveAndShareAsPDF()
                }
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(Color.white)
                .padding()
                .frame(width: 350, height: 60)
                .background(Color("Button"))
                .cornerRadius(40)
            }
        }
        .sheet(isPresented: $isSharing, content: {
            ActivityView(activityItems: [pdfURL!], applicationActivities: nil)
        })
    }
    
    func saveAndShareAsPDF() {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 350, height: 500))

        let pdfData = pdfRenderer.pdfData { context in
            context.beginPage()

            let attributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ]

            let string = "Your postcard content here"
            string.draw(at: CGPoint(x: 10, y: 10), withAttributes: attributes)
        }

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
    
    
    func image<V>(from view: V) -> UIImage? where V: View {
        let controller = UIHostingController(rootView: view)
        controller.view.bounds = CGRect(origin: .zero, size: CGSize(width: 350, height: 250))
        let targetSize = controller.view.bounds.size
        controller.view.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
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

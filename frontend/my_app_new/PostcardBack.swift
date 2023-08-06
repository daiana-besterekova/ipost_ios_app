import SwiftUI

struct PostcardBackView: View {
    var street: String
    var city: String
    var country: String
    var zipCode: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            Text("Recipient:")
                .font(.headline)
            Text(street)
            Text("\(city), \(country) \(zipCode)")
            Spacer()
            HStack {
                Spacer()
            }
            .padding()
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.white)
        .border(Color.gray, width: 2)
    }
}

struct PostcardBackView_Previews: PreviewProvider {
    static var previews: some View {
        PostcardBackView(street: "123 Main St", city: "Somewhere", country: "Kazakhstan", zipCode: "12345")
            .previewLayout(.sizeThatFits)
    }
}

//struct PostcardApp: App {
//    var body: some Scene {
//        WindowGroup {
//            PostcardBackView(street: "123 Main St", city: "Somewhere", country: "Kazakhstan", zipCode: "12345")
//        }
//    }
//}

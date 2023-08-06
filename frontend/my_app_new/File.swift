import SwiftUI

struct FrontPageView: View {
    @State private var startAction: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("Welcome to")
                        .font(.largeTitle)
                        .foregroundColor(Color("Button"))
                    
                    Text("iPostCard")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Button"))
                    
                    Image("Postcard")
                        .resizable()
                        .frame(width: 80, height: 50)
                    
                    
                    VStack {
                        Text("Experience the future of postcard creation")
                            .font(.headline)
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Button"))
                    }
                    .cornerRadius(8) // Add corner radius to the frame

                    Button(action: {
                        startAction = true
                    }) {
                        Text("Get started")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(width: 200, height: 60)
                            .background(Color("Button"))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    Spacer()
                }
                .padding(.horizontal)
                
                NavigationLink(
                    destination: PostcardCreationView(), // Replace with the view you want to navigate to
                    isActive: $startAction,
                    label: { EmptyView() }
                )
                .navigationTitle("") // Empty navigation title to hide the default back button text
                
                // Hide the actual link, we'll use the `startAction` state to control navigation
                .hidden()
            }
        }
    }
}

struct PostcardCreationView: View {
    var body: some View {
        ContentView()
        
    }
}

struct FrontPageView_Previews: PreviewProvider {
    static var previews: some View {
        FrontPageView()
    }
}

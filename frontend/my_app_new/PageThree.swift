//
//  PageThree.swift
//  my_app_new
//
//  Created by Daiana Besterekova on 05/09/2023.
//

import SwiftUI

struct PageThreeView: View {
    @State private var message: String = ""
    @State private var buttonScale: CGFloat = 1.0
    @State private var showingAlert = false
    @EnvironmentObject var sharedData: SharedData
    @State private var navigateToOutputFile = false
    @State private var startActio1: Bool = false
    @State private var isLoading = false // <-- State variable for loading animation
    
    var body: some View {
        VStack(spacing: 15) {
            // Conditionally display content based on loading state
            if isLoading {
                LoaderView() // Show loading animation
            } else {
                HStack {
                    Button(action: {
                        isLoading = true // Start loading animation
                        
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
                            isLoading = false // Stop loading animation
                            self.startActio1 = true // Navigate to next page
                        }
                        
                    }) {
                        Text("Generate")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(width: 250, height: 60)
                            .background(Color("Button"))
                            .cornerRadius(40)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Image Downloaded"), message: Text("Image has been saved to your Photos."), dismissButton: .default(Text("OK")))
                    }
                }
                
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

struct PageThreeView_Previews: PreviewProvider {
    static var previews: some View {
            let sharedData = SharedData()
            
            return PageThreeView()
                .environmentObject(sharedData)
        }
}

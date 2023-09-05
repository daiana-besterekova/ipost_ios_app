//
//  FrontPage.swift
//  my_app_new
//
//  Created by Daiana Besterekova on 05/09/2023.
//

import Foundation

import SwiftUI

struct FrontPageView: View {
    @State private var startAction: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .frame(width: 350, height: 350)
                    
                    Spacer()
                    
                    VStack {
                        Text("Experience the future of postcard creation")
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Button"))
                            .cornerRadius(8) // Add corner radius to the frame

                        Button(action: {
                            startAction = true
                        }) {
                            Text("Get started")
                                .font(.system(size: 20, weight: .heavy, design: .rounded))
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(width: 350, height: 60)
                                .background(Color("Button"))
                                .cornerRadius(40)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.bottom)
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

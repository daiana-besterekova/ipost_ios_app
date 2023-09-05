//
//  PageOne.swift
//  my_app_new
//
//  Created by Daiana Besterekova on 23/07/2023.
//

//import Foundation
import UIKit
import SwiftUI

struct PageOneView: View {
    @EnvironmentObject var sharedData: SharedData
    let options = ["Retro", "Minimalist", "Hand-drawn", "Typography-based", "Photographic", "Travel", "Contemporary/Abstract"]
    
    var body: some View {
            VStack(spacing: 15) {
                
                HStack(spacing: -10) {
                    VStack(alignment: .center) {
                        Text("Front Page")
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .bold()
                            .foregroundColor(Color("Button"))
        
                    }
                }
//                .frame(width: 150, height: 30)
//                .background(Color("Button"))
//                .clipShape(RoundedRectangle(cornerRadius: 20))

                
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
                        .font(.system(size: 12,
                              design: .rounded))
                }
            }
    }
}

struct PageOneView_Previews: PreviewProvider {
    static var previews: some View {
        PageOneView().environmentObject(SharedData())
    }
}

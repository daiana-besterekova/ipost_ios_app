//
//  Animation .swift
//  my_app_new
//
//  Created by Daiana Besterekova on 09/08/2023.
//

import Foundation
import SwiftUI

struct LoaderView: View {
    @State private var animationPhase = false
    
    let timing: Double = 0.7
    let delayIncrements: Double = 0.2
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 10, height: animationPhase ? 30 : 10)
                    .foregroundColor(Color("Button"))
                    .animation(Animation.easeInOut(duration: timing)
                                .repeatForever(autoreverses: true)
                                .delay(delayIncrements * Double(index)))
            }
        }
        .onAppear {
            animationPhase.toggle()
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}


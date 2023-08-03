//
//  MyAppApp.swift
//  MyApp
//
//  Created by Daiana Besterekova on 04/07/2023.
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
        }
    }
}

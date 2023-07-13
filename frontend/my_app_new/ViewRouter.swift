//
//  ViewRouter.swift
//  MyApp
//
//  Created by Daiana Besterekova on 04/07/2023.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    enum Page {
        case signIn
        case signUp
        case Generate
    }
    
    @Published var currentPage: Page = .signIn
}

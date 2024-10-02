//
//  coinhiveApp.swift
//  coinhive
//
//  Created by Godwin IE on 19/09/2024.
//

import SwiftUI

@main
struct coinhiveApp: App {
    @State var coinsVM = CoinsViewModel()

    var body: some Scene {
        WindowGroup {
            AllCoinsView()
                .environmentObject(coinsVM)
        }
    }
}

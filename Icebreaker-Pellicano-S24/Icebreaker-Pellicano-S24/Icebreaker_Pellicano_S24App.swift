//
//  Icebreaker_Pellicano_S24App.swift
//  Icebreaker-Pellicano-S24
//
//  Created by Frank Pellicano on 2/6/24.
//

import SwiftUI
import Firebase

@main
struct Icebreaker_Pellicano_S24App: App {
    init(){
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

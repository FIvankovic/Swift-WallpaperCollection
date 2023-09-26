//
//  WallpaperCollectionApp.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI

@main
struct WallpaperCollectionApp: App {
    
    var wallpaperLocals = WallpapersLocals();
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(wallpaperLocals)
        }
    }
}

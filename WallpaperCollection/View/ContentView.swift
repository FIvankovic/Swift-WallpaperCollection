//
//  ContentView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI

enum Tabs: Hashable {
        case wallpapers
        case favorites
        }
/*
init(){
    UITabBar.appearance().isHidden = true;
}
*/

struct ContentView: View {
    
    //Properties
    @State private var selectedTab = Tabs.wallpapers
    @State var currentTab = "Wallpapers"
    

    
    var body: some View {
            CustomTabView(selectedTab: $selectedTab)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CustomTabView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Tabs
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            WallpapersView(selectedTab: $selectedTab)
                .tabItem {
                    TabButton(image: "list.dash")
                    Text("Wallpapers")
                }
               // .background(Color.white)
                .tag(Tabs.wallpapers)
            FavoritesView()
                .tabItem {
                    TabButton(image: "heart")
                    Text("Favorites")
                }
                .tag(Tabs.favorites)
        } //TabView
        .background(Color.white)
}

struct TabButton: View{
                    
    var image: String
    
    var body: some View{
        Button{
            //withAnimation{selectedTab = image}
        } label:{
            Image(systemName: image)
        }
    }
}//TabButton end
    

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}//preview end
}//CustomTabView class end

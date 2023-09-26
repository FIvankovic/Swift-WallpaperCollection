//
//  WallpapersView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI
import SDWebImageSwiftUI

struct WallpapersView: View {
    @EnvironmentObject var wallpaperLocals: WallpapersLocals
    @Binding private var selectedTab : Tabs
    @ObservedObject var randomImages = UnsplashData()
    @State var searchText: String = ""
    @State var filterImage = [WallpapersLocal]()
    
    
    init(selectedTab: Binding<Tabs>){
        _selectedTab = selectedTab
        UITabBar.appearance().isHidden = false;
        UserDefaults.resetStandardUserDefaults()
    }
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    func performSearch(searchText: String) {
        filterImage = wallpaperLocals.list.filter { wallpaperLocal in
            wallpaperLocal.getName().localizedCaseInsensitiveContains(searchText) || wallpaperLocal.getTag1().localizedCaseInsensitiveContains(searchText) || wallpaperLocal.getTag2().localizedCaseInsensitiveContains(searchText) || wallpaperLocal.getTag3().localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        //Text("\(wallpaperLocals)")
        TabView(selection: $selectedTab){
            NavigationView{
                VStack{
                    Text("Wallpaper Collection")
                        .font(.title2)
                    if wallpaperLocals.list.isEmpty{
                        Text("No data found")
                    } else {
                        ScrollView{
                            LazyVGrid(columns: columns){
                                if filterImage.isEmpty{
                                    ForEach(wallpaperLocals.list) { lwp in
                                        NavigationLink( destination: WallpaperDetailView(wallpaper: lwp, selectedTab: $selectedTab)) {
                                            WallpaperRow(lwp: lwp)
                                        }//nav link
                                    }//loop
                                } else {
                                    ForEach(filterImage) { lwp in
                                        NavigationLink( destination: WallpaperDetailView(wallpaper: lwp, selectedTab: $selectedTab)) {
                                            WallpaperRow(lwp: lwp)
                                        }//nav link
                                    }//loop
                                }
                                if(randomImages.photoArray.isEmpty){
                                    Text("Online images could not be loaded due to an unforseen error.")
                                } else{
                                    ForEach(randomImages.photoArray, id: \.id) { photo in
                                        NavigationLink( destination: WallpaperApiDetail(wallpaperApi: photo, selectedTab: $selectedTab)){
                                            WebImage(url: URL(string: photo.urls["thumb"] ?? String()))
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                                .aspectRatio(contentMode: .fill)
                                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                                        }
                                    }//loop
                                }
                            }//LazyVGrid end
                            .padding()
                            .searchable(text: $searchText, prompt: "Search by name/tag")
                            .onChange(of: searchText, perform: performSearch)
                        }//ScrollView end
                        //.background(Color.black)
                    }//else end
                }//VStack end
            }//Navigationview end
            
        }//TabView end
        
    }//View end
}//Struct end

struct WallpapersView_Previews: PreviewProvider {
    static var previews: some View {
        WallpapersView(selectedTab: .constant(Tabs.wallpapers))
    }
}

struct WallpaperRow: View {
    var lwp: WallpapersLocal
    
    var body: some View {
        
        Image("\(lwp.name)")
            .resizable()
            .frame(width: 100, height: 100)
            .clipped()
            .aspectRatio(contentMode: .fill)
            .shadow(color: .black, radius: 2, x: 1, y: 1)
        // Text("Name: \(lwp.name)")
        //  Text("ImageType: \(lwp.imageType)")
    }
}

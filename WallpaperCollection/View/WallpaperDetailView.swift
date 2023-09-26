//
//  WallpaperDetailView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI
import Lottie

struct WallpaperDetailView: View {
    @EnvironmentObject var wallpapers: WallpapersLocals
    var wallpaper: WallpapersLocal
    @Binding var selectedTab: Tabs
    
    //Animations
    @State var favouriteInProgress = false
    @State var downloadInProgress = false
    @State var unfavoriteInProgress = false

    @State var imageInfoShow = false
    
    
    var body: some View {
        
        
        
        ZStack {
            GeometryReader{ geo in
                Image("\(wallpaper.name)")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                //*.frame(width: geo.size.width * 0.8)
                    .frame(height: geo.size.height)
            }
            
            if favouriteInProgress {
                LottieView(lottieFile: "favourite", favouriteInProgress: $favouriteInProgress, downloadInProgress: $downloadInProgress, unfavoriteInProgress: $unfavoriteInProgress)
            }
            if unfavoriteInProgress {
                LottieView(lottieFile: "unfavorite", favouriteInProgress: $favouriteInProgress, downloadInProgress: $downloadInProgress, unfavoriteInProgress: $unfavoriteInProgress)
            }
            if downloadInProgress {
                LottieView(lottieFile: "download", favouriteInProgress: $favouriteInProgress, downloadInProgress: $downloadInProgress, unfavoriteInProgress: $unfavoriteInProgress)
            }
            
            var favoriteArray = (UserDefaults.standard.array(forKey: "favorites") ?? []) as! [String]
            
            
           //Extra information button
            Button(action: {
                imageInfoShow = true
            }, label: {
                Label("", systemImage: "doc")
            })
            .alert(isPresented: $imageInfoShow) {
                Alert(
                    title: Text("\(wallpaper.getName())\n"),
                    message: Text("Tags: \(wallpaper.getTag1()), \(wallpaper.getTag2()), \(wallpaper.getTag3())\n"), dismissButton: .default(Text("Dismiss"))
                )
            }
            .offset(x: 170, y: 130)
            .buttonStyle(CircleButtonStyle())
            
            
            //Favorite/Unfavorite Button
            Button(action: { if !favoriteArray.contains(wallpaper.getName()) {
                
                favoriteArray.append(wallpaper.getName())
                self.favouriteInProgress.toggle()
                
            } else {
                let index = favoriteArray.firstIndex(of: wallpaper.getName())
                favoriteArray.remove(at: index ?? Int())
                self.unfavoriteInProgress.toggle()
            }
                UserDefaults.standard.set(favoriteArray, forKey:"favorites")
                
            }, label: {
                if(!favoriteArray.contains(wallpaper.getName())){
                    Label( "" ,systemImage: "heart")
                } else {
                    Label( "" ,systemImage: "heart.slash")
                           
                }})
                .offset(x:170, y: 180)
                .buttonStyle(CircleButtonStyle())//Button end
            
            
            
            //Download Button
            Button(action: {
                self.downloadInProgress.toggle()
                let image = UIImage(named: "\(wallpaper.name)")
                guard let image = image else { return }
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: image)
            }, label: {
                Label("", systemImage: "square.and.arrow.down")})
            .buttonStyle(CircleButtonStyle())
            .offset(x:170, y: 230)
            .frame(alignment: .center)
            
        }//ZStack
        
    }
}




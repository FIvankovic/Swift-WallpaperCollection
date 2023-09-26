//
//  WallpaperApiDetail.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI
import SDWebImageSwiftUI

struct WallpaperApiDetail: View {
    @ObservedObject var randomImages = UnsplashData()
    var wallpaperApi: Photo
    @Binding var selectedTab: Tabs
    
    //Animations
    @State var favouriteInProgress = false
    @State var downloadInProgress = false
    @State var unfavoriteInProgress = false

    
    var body: some View {
     
        ZStack {
            GeometryReader{ geo in
                WebImage(url: URL(string: wallpaperApi.urls["regular"] ?? String()))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    //.frame(width: geo.size.width * 0.8)
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
            
            //Favorite/Unfavorite Button
            Button(action: { if !favoriteArray.contains(wallpaperApi.urls["thumb"] ?? String()) {
                
                favoriteArray.append(wallpaperApi.urls["thumb"] ?? String())
                self.favouriteInProgress.toggle()
                
            } else {
                let index = favoriteArray.firstIndex(of: wallpaperApi.urls["thumb"] ?? String())
                favoriteArray.remove(at: index ?? Int())
                self.unfavoriteInProgress.toggle()
                
            }
                UserDefaults.standard.set(favoriteArray, forKey:"favorites")
                
            }, label: {
                if(!favoriteArray.contains(wallpaperApi.urls["thumb"] ?? String())){
                    Label( "" ,systemImage: "heart")
                } else {
                    Label( "" ,systemImage: "heart.slash")
                           
                }})
                .offset(x:170, y: 180)
                .buttonStyle(CircleButtonStyle())//Button end

            //Download Button
            Button(action: {
                self.downloadInProgress.toggle()
                UIImageView().loadFrom(URLAddress: wallpaperApi.urls["full"] ?? String())
                
            }, label: {
                Label("", systemImage: "square.and.arrow.down")})
                .buttonStyle(CircleButtonStyle())
                .offset(x:170, y: 230)
                .frame(alignment: .center)
            
        }//ZStack
        
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    ImageSaver().writeToPhotoAlbum(image: loadedImage)
                }
            }
        }
    }
}


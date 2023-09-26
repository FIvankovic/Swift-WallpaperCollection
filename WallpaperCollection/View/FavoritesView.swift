//
//  FavoritesView.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesView: View {
    @State var favoriteArray = UserDefaults.standard.stringArray(forKey: "favorites") ?? [String]()
    
    
    
    var body: some View {
        TabView{
            List{
                createFavorites(favoriteArray: $favoriteArray)
                deleteAllButton()
            }//ScrollView end
            .refreshable {
                favoriteArray = UserDefaults.standard.stringArray(forKey: "favorites") ?? [String]()
            }
        }//TabView end
    }//body end
}//End

struct deleteAllButton: View{
    
    @State private var deleteAllConfirmShow = false
    
    var body: some View{
        Button(role: .destructive, action:{
            deleteAllConfirmShow = true
            

        }, label:{
            Text("Delete All Favorite Wallpapers")
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
        })
        .confirmationDialog("Do you wish to delete all your favorites wallpapers?", isPresented: $deleteAllConfirmShow, titleVisibility: .visible){
            Button("Yes", role: .destructive){
                let emptyArr = [String]()
                UserDefaults.standard.set(emptyArr, forKey: "favorites")
            }
            Button("No", role: .cancel){
                
            }
        }
    }
}


struct createFavorites: View{
    
    @Binding var favoriteArray: [String]
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    
    var body: some View{
        LazyVGrid(columns: columns){
            ForEach(favoriteArray, id: \.self) { picture in
                if(verifyURL(urlString: picture)){
                    WebImage(url: URL(string: "\(picture)"))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("\(picture)")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .aspectRatio(contentMode: .fill)
                }
            }//loop
        }//LazyVGrid end
        .padding()
    }
    
    func verifyURL(urlString: String?) -> Bool{
        if let urlString = urlString {
            if let url = NSURL(string: urlString){
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        
        return false
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

//
//  WallpapersLocalReader.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import Foundation


class WallpapersLocals: ObservableObject{
    @Published var list: [WallpapersLocal] = []
    @Published var selectedWallpaper: WallpapersLocal?
    
    init(){
        
        //load data
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
                    
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
               // print("\(String.init(describing: tempDict))")
                let tempArray = tempDict["wallpapersLocals"] as! Array<[String:Any]>
                
                var tempWallpaper: [WallpapersLocal] = []
                
                for dict in tempArray {
                    //print("\(dict)")
                    let name = dict["name"]! as! String
                    let imageType = dict["imageType"] as! String
                    let tag1 = dict["tag1"] as! String;
                    let tag2 = dict["tag2"] as! String;
                    let tag3 = dict["tag3"] as! String;
                    
                    //Create the WallpapersLocal class
                    let w = WallpapersLocal(name: name, imageType: imageType, tag1: tag1, tag2: tag2, tag3: tag3)
                    
                    
                    //append
                    tempWallpaper.append(w);
                    
                }//for loop end
                            
                //check to see if the parks were created correctly
                print("There are \(tempWallpaper.count) wallpapers")
                print("\(tempWallpaper)")

                self.list = tempWallpaper.sorted(by:{ $0.getName() < $1.getName() })
            
            
                print(self.list)
            } catch {
                print(error)
            }
        }//if end
    }
}//class end

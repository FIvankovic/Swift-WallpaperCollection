//
//  WallpapersLocal.swift
//  WallpaperCollection
//
//  Created by Filipa Ivankovic & Lucijan Pavic
//

import Foundation


class WallpapersLocal: NSObject, Identifiable{
    
    
    //Properties
    var id = UUID();
    var name: String = "";
    var imageType: String = "";
    var tag1: String = "";
    var tag2: String = "";
    var tag3: String = "";
    
    
    
    func setName(name: String){
        self.name = name;
    }
    
    func getName() -> String{
        return self.name
    }
    
    func setImageType(imageType: String){
        self.imageType = imageType
    }
    
    func getImageType() -> String{
        return self.imageType
    }
    
    //Tag1
    func setTag1(tag1: String){
        self.tag1 = tag1
    }
    func getTag1() -> String{
        return self.tag1
    }
    
    
    //Tag2
    func setTag2(tag2: String){
        self.tag2 = tag2
    }
    func getTag2() -> String{
        return self.tag2
    }
    
    //Tag3
    func setTag3(tag3: String){
        self.tag3 = tag3
    }
    func getTag3() -> String{
        return self.tag3
    }
    
    
    
    init(name: String, imageType: String, tag1: String, tag2: String, tag3: String){
        super.init()
        self.setName(name: name)
        self.setImageType(imageType: imageType)
        self.setTag1(tag1: tag1)
        self.setTag2(tag2: tag2)
        self.setTag3(tag3: tag3)
    }
    
    
    override var description: String{
        return "{\n\t name: \(getName()) \n\t imageType: \(getImageType()) \n\t tag1: \(getTag1()) \n\t tag2: \(getTag2()) \n\t tag3: \(getTag3()) \n}"
    }
    
    convenience override init(){
        self.init(name: "Unknown", imageType: "Unknown", tag1: "Unknown", tag2: "Unknown", tag3: "Unknown");
    }//convenience init
}

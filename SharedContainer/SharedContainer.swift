//
//  SharedContainer.swift
//  SharedContainer
//
//  Created by yusiyang on 16/2/1.
//  Copyright © 2016年 100tv. All rights reserved.
//

import Foundation
import RealmSwift

public class SharedContainer{
    
    static let groupID = "group.com.100tv.TransPadQ-Phi"
    static let folderPath = "Library/Caches"
    static let fileManager = FileManager.default
    static let pathURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupID)!.appendingPathComponent(folderPath)
    static let path = pathURL.path
    
    static let shareDefault = UserDefaults(suiteName: groupID)!
    
    static let realmPath = pathURL.appendingPathComponent("share.realm").path
    
    public static func initial(){
        print(path)
    }
    
    public static func writeFile(data:NSData,name:String) -> Bool {
        let result = fileManager.createFile(atPath: "\(path)/\(name)", contents: data as Data, attributes: nil)
        let file = File(absoluteURL: (pathURL.appendingPathComponent(name) as NSURL) as URL)
        let realm = try! Realm(fileURL: URL(fileURLWithPath: realmPath))
        
        try! realm.write { () -> Void in
            let count = realm.objects(File).filter("fileName = '\(file.fileName!)'").count
            if count == 0 {
                realm.add(file)
            }
        }
        
        return result
    }
    
    public static func deleteFile(deletedFile:File) {
        do{
            print(deletedFile.filePath)
            try fileManager.removeItem(atPath: deletedFile.filePath!)
            let realm = try! Realm(fileURL: URL(fileURLWithPath: realmPath))
            
            try! realm.write({ () -> Void in
                realm.delete(deletedFile)
            })
            
        }catch{
            print("deleteFile erro")
        }
    }
    
    public static func getFileNameList() -> [String]? {
        var result:[String]
        do{
            result = try fileManager.contentsOfDirectory(atPath: path)
            return result
        }catch{
            print("getFileNameList erro")
        }
        return nil
    }
    
    public static func getFileList() -> [File] {
        let realm = try! Realm(fileURL: URL(fileURLWithPath: realmPath))
        let fileList = realm.objects(File).sorted(byProperty: "index")
        var result = [File]()
        for file in fileList {
            result.append(file)
        }
        return result
    }
    
    public static func swap(from:Int,to:Int){
        print(from)
        print(to)
        let realm = try! Realm(fileURL: URL(fileURLWithPath: realmPath))
        try! realm.write { () -> Void in
            let fromFile = realm.objects(File).filter("index == \(from)").first!
            let toFile = realm.objects(File).filter("index == \(to)").first!
            let tempIndex = toFile.index
            if fromFile.index < toFile.index {
                for file in realm.objects(File).filter("index > \(fromFile.index) and index <= \(toFile.index)") {
                    file.index = file.index - 1
                }
            } else {
                for file in realm.objects(File).filter("index >= \(toFile.index) and index < \(fromFile.index)") {
                    file.index = file.index + 1
                }
            }
            fromFile.index = tempIndex
            
        }
        
    }
    
    public static func getFileData(absolutePath:NSURL) -> NSData{
        return NSData(contentsOf: absolutePath as URL)!
    }
    
}

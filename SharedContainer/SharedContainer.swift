//
//  SharedContainer.swift
//  SharedContainer
//
//  Created by yusiyang on 16/2/1.
//  Copyright © 2016年 100tv. All rights reserved.
//

import Foundation
public class SharedContainer{
    public static func p(){
        print("DDDDDff")
    }
    static let groupID = "group.com.100tv.TransPadQ"
    static let folderPath = "Library/Caches"
    static let fileManager = NSFileManager.defaultManager()
    static let pathURL = fileManager.containerURLForSecurityApplicationGroupIdentifier(groupID)!.URLByAppendingPathComponent(folderPath)
    static let path = pathURL.path!
    
    public static func writeFile(data:NSData,name:String) -> Bool {
        let result = fileManager.createFileAtPath("\(path)/\(name)", contents: data, attributes: nil)
        
        print(result)
        return result
    }
    
    public static func deleteFile(name:String) {
        do{
            print(path)
            print(name)
            try fileManager.removeItemAtPath("\(path)/\(name)")
            
        }catch{
            print("deleteFile erro")
        }
    }
    
    public static func getFileNameList() -> [String]? {
        var result:[String]
        do{
            result = try fileManager.contentsOfDirectoryAtPath(path)
            return result
        }catch{
            print("getFileNameList erro")
        }
        return nil
    }
    
    public static func getFileList() -> [File]? {
        var result = [File]()
        var names:[String]
        do{
            names = try fileManager.contentsOfDirectoryAtPath(path)
            for name in names {
                let file = File(absoluteURL: pathURL.URLByAppendingPathComponent(name))
                result.append(file)
            }
            return result
        }catch{
            print("getFileNameList erro")
        }
        return nil
    }
    
    public static func getFileData(name:String) -> NSData {
        return NSData(contentsOfURL: pathURL.URLByAppendingPathComponent(name))!
    }
    
    public static func getFileData(absolutePath:NSURL) -> NSData{
        return NSData(contentsOfURL: absolutePath)!
    }
    
}
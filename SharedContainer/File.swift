//
//  File.swift
//  SharedContainer
//
//  Created by yusiyang on 16/2/1.
//  Copyright © 2016年 100tv. All rights reserved.
//

import Foundation
public class File {
    
    public static let TYPE_IMAGE = "TYPE_IMAGE"
    public static let TYPE_AUDIO = "TYPE_AUDIO"
    public static let TYPE_VIDEO = "TYPE_VIDEO"
    public static let TYPE_DATA = "TYPE_DATA"
    public static let TYPE_ELSE = "TYPE_ELSE"
    
    public var fileName:String?
    public var filePath:String?
    public var filePathURL:NSURL?
    public var extention:String?
    public var type:String?
    
    init(absoluteURL:NSURL){
        
        filePathURL = absoluteURL
        filePath = absoluteURL.path
        fileName = self.filePath?.componentsSeparatedByString("/").last
        extention = self.fileName?.componentsSeparatedByString(".").last?.lowercaseString
        
        switch (extention!) {
        case "jpg","jpeg","png" :
            type = File.TYPE_IMAGE
        case "mp3","wma" :
            type = File.TYPE_AUDIO
        case "mp4","wmv","avi","mpeg":
            type = File.TYPE_VIDEO
        case "txt","doc","xls","ppt","pdf":
            type = File.TYPE_DATA
        default:
            type = File.TYPE_ELSE
            break
        }
        
    }
    
    
}
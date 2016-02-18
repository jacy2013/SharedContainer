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
    public static let TYPE_DOC = "TYPE_DOC"
    public static let TYPE_PPT = "TYPE_PPT"
    public static let TYPE_XLS = "TYPE_XLS"
    public static let TYPE_HTML = "TYPE_HTML"
    public static let TYPE_PUB = "TYPE_PUB"
    public static let TYPE_PDF = "TYPE_PDF"
    public static let TYPE_TXT = "TYPE_TXT"
    
    public static let TYPE_ELSE = "TYPE_ELSE"
    
    public var fileName:String?
    public var filePath:String?
    public var filePathURL:NSURL?
    public var suffix:String?
    public var type:String?
    
    init(absoluteURL:NSURL){
        
        filePathURL = absoluteURL
        filePath = absoluteURL.path
        fileName = self.filePath?.componentsSeparatedByString("/").last
        suffix = self.fileName?.componentsSeparatedByString(".").last?.lowercaseString
        
        switch (suffix!) {
            
        case "jpg","jpeg","png" :
            type = File.TYPE_IMAGE
        case "mp3","wma" :
            type = File.TYPE_AUDIO
        case "mp4","wmv","avi","mpeg":
            type = File.TYPE_VIDEO
        case "txt":
            type = File.TYPE_TXT
        case "doc","docx":
            type = File.TYPE_DOC
        case "ppt","pptx":
            type = File.TYPE_PPT
        case "xls","xlsx":
            type = File.TYPE_XLS
        case "html":
            type = File.TYPE_HTML
        case "pub":
            type = File.TYPE_PUB
        case "pdf":
            type = File.TYPE_PDF
        default:
            type = File.TYPE_ELSE
            break
        }
    }
    
}

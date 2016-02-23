//
//  File.swift
//  SharedContainer
//
//  Created by yusiyang on 16/2/1.
//  Copyright © 2016年 100tv. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

public class File:Object {
    
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
    
    static let groupID = "group.com.100tv.TransPadQ"
    static let folderPath = "Library/Caches"
    static let fileManager = NSFileManager.defaultManager()
    static let pathURL = fileManager.containerURLForSecurityApplicationGroupIdentifier(groupID)!.URLByAppendingPathComponent(folderPath)
    static let realmPath = pathURL.URLByAppendingPathComponent("share.realm").path!
    
    dynamic public var index = 0
    dynamic public var fileName:String?
    dynamic public var filePath:String?
    dynamic public var filePathURL:String?
    dynamic public var suffix:String?
    dynamic public var type:String?
    
    init(absoluteURL:NSURL){
        super.init()
        let r = try! Realm(path: File.realmPath)
        if let maxIndex = r.objects(File).sorted("index").last?.index {
            index = maxIndex + 1
        }else{
            index = 0
        }
        filePathURL = absoluteURL.absoluteString
        filePath = absoluteURL.path
        fileName = filePath?.componentsSeparatedByString("/").last
        suffix = absoluteURL.pathExtension!.lowercaseString
        
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
    
    required public init() {
        super.init()
    }
    
    override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
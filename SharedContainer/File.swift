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

open class File : RealmSwift.Object{
    
    open static let TYPE_IMAGE = "TYPE_IMAGE"
    open static let TYPE_AUDIO = "TYPE_AUDIO"
    open static let TYPE_VIDEO = "TYPE_VIDEO"
    //    public static let TYPE_DATA = "TYPE_DATA"
    open static let TYPE_DOC = "TYPE_DOC"
    open static let TYPE_PPT = "TYPE_PPT"
    open static let TYPE_XLS = "TYPE_XLS"
    open static let TYPE_OUTLOOK = "TYPE_OUTLOOK"
    open static let TYPE_ONENOTE = "TYPE_ONENOTE"
    open static let TYPE_ACCESS = "TYPE_ACCESS"
    open static let TYPE_HTML = "TYPE_HTML"
    open static let TYPE_PUB = "TYPE_PUB"
    open static let TYPE_PDF = "TYPE_PDF"
    open static let TYPE_TXT = "TYPE_TXT"
    
    open static let TYPE_ELSE = "TYPE_ELSE"
    
    static let groupID = "group.com.100tv.TransPadQ"
    static let folderPath = "Library/Caches"
    static let fileManager = FileManager.default
    static let pathURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupID)?.appendingPathComponent(folderPath)
    static let realmPath = pathURL?.appendingPathComponent("share.realm").path
    
    dynamic open var index = 0
    dynamic open var fileName:String?
    dynamic open var filePath:String?
    dynamic open var filePathURL:String?
    dynamic open var suffix:String?
    dynamic open var type:String?
    
    init(absoluteURL:URL){
        super.init()
        let r = try! Realm(fileURL: URL(fileURLWithPath: File.realmPath!))
        if let maxIndex = r.objects(File.self).sorted(byProperty: "index").last?.index {
            index = maxIndex + 1
        }else{
            index = 0
        }
        filePathURL = absoluteURL.absoluteString
        filePath = absoluteURL.path
        fileName = filePath?.components(separatedBy: "/").last
        suffix = absoluteURL.pathExtension.lowercased()
        
        switch (suffix!) {
            
        case "jpg","jpeg","png","bmp","gif" :
            type = File.TYPE_IMAGE
        case "mp3","wma" :
            type = File.TYPE_AUDIO
        case "mp4","wmv","avi","aiff","mov","mpeg","mpg" :
            type = File.TYPE_VIDEO
        case "txt":
            type = File.TYPE_TXT
        case "doc","docx","wps":
            type = File.TYPE_DOC
        case "ppt","pptx","dps":
            type = File.TYPE_PPT
        case "xls","xlsx","et":
            type = File.TYPE_XLS
        case "html","htm","xhtml","asp","aspx","php","jsp":
            type = File.TYPE_HTML
        case "pub":
            type = File.TYPE_PUB
        case "pdf":
            type = File.TYPE_PDF
        case "mdb":
            type = File.TYPE_ACCESS
        case "one":
            type = File.TYPE_ONENOTE
        case "oft","msg":
            type = File.TYPE_OUTLOOK
        default:
            type = File.TYPE_ELSE
            break
        }
    }
    
    required public init() {
        super.init()
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}

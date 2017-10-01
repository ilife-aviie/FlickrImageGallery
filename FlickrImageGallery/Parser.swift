//
//  Parser.swift
//  FlickrImageGallery
//
//  Created by Avie on 01/10/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation

class Parser: NSObject, XMLParserDelegate {
    let xmlParser: XMLParser
    private var dataValues: [FeedData]
    private var dataValue: [String: String]
    private var currentElement: String = ""
    private var start = false
    private var completion: (([FeedData]) -> Void)?
    
    init(parser: XMLParser) {
        self.xmlParser = parser
        self.dataValues = []
        self.dataValue = [:]
        super.init()
        self.xmlParser.delegate = self
    }
    
    func parse(completion: @escaping ([FeedData]) -> Void) {
        self.completion = completion
        self.xmlParser.parse()
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Parser started.")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "entry" {
            dataValue = [:]
            start = true
        }
        
        if currentElement == "link" {
            dataValue[currentElement] = attributeDict["href"]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if start && currentElement == "title" && dataValue[currentElement] == nil {
            dataValue[currentElement] = string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "entry", dataValue.count > 0 {
            let imageData = FeedData(imageUrl: dataValue["link"]!, title: dataValue["title"]!)
            dataValues.append(imageData)
            start = false
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("dataValues:\(dataValues)")
        print("Parser ended.")
        self.completion?(dataValues)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parser encountered an error:\(parseError)")
    }
}

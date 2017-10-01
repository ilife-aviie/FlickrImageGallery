//
//  ParserTests.swift
//  FlickrImageGalleryTests
//
//  Created by Avie on 02/10/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class ParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let path = Bundle.main.path(forResource: "ParserMockData", ofType: "txt")
        let contents = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        Parser(parser: XMLParser(data: contents)).parse(completion: { feeds in
            XCTAssert(feeds.count > 0)
            
            let firstFeed = feeds.first
            XCTAssertEqual("https://farm5.staticflickr.com/4482/23588569918_dbbd8313b8_b.jpg", firstFeed?.imageUrl)
            
            let lastFeed = feeds.last
            XCTAssertEqual("https://farm5.staticflickr.com/4459/37440405401_7358a46671_b.jpg", lastFeed?.imageUrl)
        })
        
        XCTAssertNotNil(contents, "Mock data not available.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

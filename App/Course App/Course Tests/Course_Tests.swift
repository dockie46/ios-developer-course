//
//  Course_Tests.swift
//  Course Tests
//
//  Created by Patrik Urban on 10.05.2024.
//

import XCTest
@testable import App_Course_Dev

final class Course_Tests: XCTestCase {
    
    var service: KeychainServicing!
    override func setUpWithError() throws {
        service = KeychainService(keychainManager: MockKeychainManager())
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testExample() throws {
        let testValue = "test_token_value"
        
        try service.storeAuthData(authData: testValue)
        XCTAssert(true)
        let value = try service.fetchAuthData()
        XCTAssert(value == testValue)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

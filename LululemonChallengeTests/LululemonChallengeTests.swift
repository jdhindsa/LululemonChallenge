//
//  LululemonChallengeTests.swift
//  LululemonChallengeTests
//
//  Created by Jason Dhindsa on 2021-08-29.
//

import XCTest
@testable import LululemonChallenge

class LululemonChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGarmentNameInViewModel() {
        let currentDate = Date()
        let garment = JDGarment(garmentName: "Sweater", creationDate: currentDate)
        let garmentVM = JDGarmentViewModel(garment: garment)
        XCTAssertEqual(garment.garmentName, garmentVM.garmentName)
    }
    
    func testGarmentCreationDateInViewModel() {
        let currentDate = Date()
        let garment = JDGarment(garmentName: "Yoga Pants", creationDate: currentDate)
        let garmentVM = JDGarmentViewModel(garment: garment)
        XCTAssertEqual(garment.creationDate, garmentVM.creationDate)
    }
}

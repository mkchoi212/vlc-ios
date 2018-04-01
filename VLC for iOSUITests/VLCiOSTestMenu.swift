//
//  Screenshots.swift
//  VLC-iOS-UITests
//
//  Created by Mike Choi on 3/30/18.
//  Copyright © 2018 VideoLAN. All rights reserved.
//
//  Screenshots taken
//  - Audio tab home
//  - Local Network tab home
//  - Video tab home
//

import Foundation
import XCTest

class VLCiOSTestMenu: XCTestCase {
    let app = XCUIApplication()
    let moreTab = XCUIApplication().tabBars.buttons.element(boundBy: 4)
    
    override func setUp() {
        super.setUp()
        XCUIDevice.shared().orientation = .portrait
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func localizedString(key: String) -> String {
        let localizationBundle = Bundle(path: Bundle(for: VLCiOSTestMenu.self).path(forResource: deviceLanguage, ofType: ".lproj")!)!
        let result = NSLocalizedString(key, bundle: localizationBundle, comment: "")
        return result
    }
    
    func testNavigationToAudioTab() {
        let audio = localizedString(key: "AUDIO")
        app.tabBars.buttons[audio].tap()
        XCTAssertNotNil(app.navigationBars[audio])
        
        snapshot("audio_tab")
    }
    
    func testNavigationToNetworkTab() {
        let localNetwork = localizedString(key: "LOCAL_NETWORK")
        app.tabBars.buttons[localNetwork].tap()
        XCTAssertNotNil(app.navigationBars[localNetwork])
        
        snapshot("network_tab")
    }
    
    func testNavigationToVideoTab() {
        app.tabBars.buttons["Video"].tap()
        XCTAssertNotNil(app.navigationBars["Video"])
        
        snapshot("video_tab")
    }
    
    func testNavigationToSettingsTab() {
        let settings = localizedString(key: "Settings")
        app.tabBars.buttons[settings].tap()
        XCTAssertNotNil(app.navigationBars[settings])
    }
    
    func testNavigationToCloudServices() {
        moreTab.tap()
        
        let cloudServices = localizedString(key: "CLOUD_SERVICES")
        app.cells.staticTexts[cloudServices].tap()
        XCTAssertNotNil(app.navigationBars[cloudServices])
    }
    
    func testNavigationToDownloads() {
        moreTab.tap()
        
        let downloads = localizedString(key: "DOWNLOAD_FROM_HTTP")
        app.cells.staticTexts[downloads].tap()
        XCTAssertNotNil(app.navigationBars[downloads])
    }
    
    func testNavigationToNetworkStream() {
        moreTab.tap()
        
        let network = localizedString(key: "OPEN_NETWORK")
        app.cells.staticTexts[network].tap()
        XCTAssertNotNil(app.navigationBars[network])
    }
    
    func testNavigationToAbout() {
        moreTab.tap()
        
        let about = localizedString(key: "ABOUT_APP")
        app.cells.staticTexts[about].tap()
        XCTAssertNotNil(app.navigationBars[about])
    }
}

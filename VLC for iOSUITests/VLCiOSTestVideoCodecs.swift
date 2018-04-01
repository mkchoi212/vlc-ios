//
//  VLCiOSTestVideoCodecs.swift
//  VLC for iOSUITests
//
//  Created by Mike Choi on 3/30/18.
//  Copyright © 2018 VideoLAN. All rights reserved.
//
//  Screenshots taken
//  - Video playback (Jellyfish)
//

import Foundation
import XCTest
import UIKit

class VLCiOSTestVideoCodecs: XCTestCase {
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
    
    func testDownload() {
        download(name: "http://jell.yfish.us/media/jellyfish-10-mbps-hd-h264.mkv")
        app.navigationBars["VLCMovieView"].buttons[localizedString(key: "VIDEO_ASPECT_RATIO_BUTTON")].tap()
        snapshot("playback")
    }
    
    func testMovCodec() {
        stream(named: "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov")
    }
    
    func testHEVCCodec10b() {
        stream(named: "http://jell.yfish.us/media/jellyfish-90-mbps-hd-hevc-10bit.mkv")
    }
    
    func testHEVCCodec() {
        stream(named: "http://jell.yfish.us/media/jellyfish-25-mbps-hd-hevc.mkv")
    }
    
    func testH264Codec() {
        stream(named: "http://jell.yfish.us/media/jellyfish-25-mbps-hd-h264.mkv")
    }
    
    func download(name fileName: String) {
        moreTab.tap()
        app.staticTexts[localizedString(key: "DOWNLOAD_FROM_HTTP")].tap()
        
        let downloadTextfield = app.textFields["http://myserver.com/file.mkv"]
        downloadTextfield.clearAndEnter(text: fileName)
        app.buttons["Download"].tap()
        
        let cancelDownloadButton = app.buttons["flatDeleteButton"]
        let predicate = NSPredicate(format: "exists == 0")
        expectation(for: predicate, evaluatedWith: cancelDownloadButton, handler: nil)
        
        waitForExpectations(timeout: 20.0) { err in
            XCTAssertNil(err)
            downloadTextfield.typeText("\n")
            self.moreTab.tap()
            self.app.tabBars.buttons["Video"].tap()
            self.app.collectionViews.cells.element(boundBy: 0).tap()
        }
    }
    
    func stream(named fileName: String) {
        moreTab.tap()
        app.staticTexts[localizedString(key: "OPEN_NETWORK")].tap()
        
        let addressTextField = app.textFields["http://myserver.com/file.mkv"]
        addressTextField.clearAndEnter(text: fileName)
        
        app.buttons[localizedString(key: "OPEN_NETWORK")].tap()
        
        let displayTime = app.buttons["--:--"]
        let zeroPredicate = NSPredicate(format: "exists == 0")
        expectation(for: zeroPredicate, evaluatedWith: displayTime, handler: nil)
        
        waitForExpectations(timeout: 20.0) { err in
            XCTAssertNil(err)
            self.app.otherElements[self.localizedString(key: "VO_VIDEOPLAYER_TITLE")].doubleTap()
            let playPause = self.app.buttons[self.localizedString(key: "PLAY_PAUSE_BUTTON")]
            let onePredicate = NSPredicate(format: "exists == 1")
            self.expectation(for: onePredicate, evaluatedWith: playPause, handler: nil)
            self.waitForExpectations(timeout: 20.0, handler: nil)
        }
    }
}

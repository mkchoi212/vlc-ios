//
//  XCUIElement+Helpers.swift
//  VLC for iOSUITests
//
//  Created by Mike Choi on 3/30/18.
//  Copyright © 2018 VideoLAN. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {
    func clearAndEnter(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        tap()
        
        let deleteString = stringValue.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        typeText(deleteString)
        typeText(text)
    }
}

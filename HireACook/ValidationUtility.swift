//
//  ValidationUtility.swift
//  HireACook
//
//  Created by Suman Chatterjee on 01/11/2015.
//  Copyright © 2015 Suman Chatterjee. All rights reserved.
//

import UIKit

extension String{
    
func isAValidPostCode() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z]{1,2}[0-9Rr][0-9A-Za-z]?\\s?[0-9][ABD-HJLNP-UW-Zabd-hjlnp-uw-z]{2}$", options: [.CaseInsensitive])
        return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count)) != nil
    }
}

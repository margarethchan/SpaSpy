//
//  RedFlags.swift
//  SpaSpy
//
//  Created by C4Q on 5/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

let redFlags = ["Buzzer-controlled entrance",
                "Locked front door",
                "Discreet side or back door entrance",
                "Windows covered from outside view",
                "Business front unmarked or unnamed",
                "Security camera monitoring entrance",
                "No Yelp presence/business reviews",
                "Listed on sexual service website",
                "Open 24 hours a day",
                "Open at odd business hours",
                "Serves primarily or only male clientele",
                "Prices significantly below market-level",
                "Workers appear to live there",
                "Workers speak little to no English",
                "Workers appear fearful",
                "Workers unable to perform non-sexual job",
]

class Flag: Codable {
    let description: String
    let isSelected: Bool
    
    init(description: String, isSelected: Bool) {
        self.description = description
        self.isSelected = isSelected
    }
    
}

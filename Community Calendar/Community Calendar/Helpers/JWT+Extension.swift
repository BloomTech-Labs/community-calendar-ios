//
//  JWT+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/4/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import JWTDecode
import Apollo

extension JWT {
    var ccId: String? {
        claim(name: "http://cc_id").string
    }
}

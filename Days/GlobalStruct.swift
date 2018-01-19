//
//  GlobalStruct.swift
//  Days
//
//  Created by Daniel Moi on 19/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import UIKit

struct C {
    struct Colors {
        static let Primary = UIColor(named: "Primary")
        static let Alert = UIColor(named: "Alert")
        static let Inactive = UIColor(named: "Inactive")
        static let TextNormal = UIColor.black
        static let TextInactive = UIColor.lightGray
        
        static let BtnText = UIColor.white
        static let BtnTextInactive = UIColor.lightGray
        static let BtnBgPrimary = C.Colors.Primary
        static let BtnBgInactive = C.Colors.Inactive
    }
    
}

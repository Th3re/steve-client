//
//  Assembler.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Swinject
import Foundation

extension Assembler {
    static var `default` = {
        return Assembler([EnvironmentAssembly(),
                          LocationAssembly(),
                          AccountAssembly(),
                          NetworkAssembly()])
    }()
}

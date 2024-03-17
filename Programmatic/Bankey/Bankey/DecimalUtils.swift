//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Junyoo on 3/17/24.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

//
//  ApiError.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case forbidden              // 403
    case notFound               // 404
    case conflict               // 409
    case internalServerError    // 500
}

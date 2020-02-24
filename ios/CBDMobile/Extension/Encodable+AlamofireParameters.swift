//
//  Encodable+AlamofireParameters.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/21.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

import Alamofire

extension Encodable {
    var alamofireParameters: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? Parameters }
    }
}

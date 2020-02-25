//
//  DeviceEndpoint.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum DeviceEndpoint {
    
    case readDevices
    case readDevice(id: String)
    case createDevice(parameters: Parameters)
    case updateDevice(id: String, parameters: Parameters)
    case deleteDevice(id: String)
    
}

extension DeviceEndpoint: APIConvertible {
    
    var method: HTTPMethod {
        switch self {
        case .readDevices,
             .readDevice:
            return .get
        case .createDevice:
            return .post
        case .updateDevice:
            return .put
        case .deleteDevice:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .readDevices,
             .createDevice(_):
            return "/devices"
        case .readDevice(let id),
             .updateDevice(let id, _),
             .deleteDevice(let id):
            return "/devices/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .readDevices,
             .readDevice,
             .deleteDevice:
            return nil
        case .createDevice(let parameters),
             .updateDevice(_, let parameters):
            return parameters
        }
    }

}

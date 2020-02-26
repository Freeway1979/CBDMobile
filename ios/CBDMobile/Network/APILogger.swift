//
//  APILogger.swift
//  CBDMobile
//
//  Created by migao2 on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire

private enum APIStatus {
    case resumed
    case suspended
    case finished
    case canceled
    
    var description: String {
        switch self {
        case .resumed:
            return "Request Started"
        case .suspended:
            return "Request Suspended"
        case .finished:
            return "Request Finished"
        case .canceled:
            return "Request Canceled"
        }
    }
}

final class APILogger: EventMonitor {
    
    func requestDidResume(_ request: Request) {
        let message = getLogMessage(request, APIStatus.resumed)
        NSLog(message)
    }
    
    func requestDidSuspend(_ request: Request) {
        let message = getLogMessage(request, APIStatus.suspended)
        NSLog(message)
    }
    
    func requestDidFinish(_ request: Request) {
        let message = getLogMessage(request, APIStatus.finished)
        NSLog(message)
    }
    
    func requestDidCancel(_ request: Request) {
        let message = getLogMessage(request, APIStatus.canceled)
        NSLog(message)
    }
    
    private func getLogMessage(_ request: Request, _ apiStatus: APIStatus) -> String {
        return """
        \(apiStatus.description): \(request)
        Body Data: \(getRequestBody(request))
        """
    }
    
    private func getRequestBody(_ request: Request) -> String {
        return request.request.flatMap {
            $0.httpBody.map {
                String(decoding: $0, as: UTF8.self)
            }
        } ?? "Empty"
    }
    
}

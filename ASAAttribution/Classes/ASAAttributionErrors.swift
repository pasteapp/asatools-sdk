//
//  ASAAttributionErrors.swift
//  ASAAttribution
//
//  Created by Vladislav Dugnist on 16.11.2021.
//

import Foundation

public enum ASAAttributionErrorCodes: Int {
    case unsupportedIOSVersion
    case errorGeneratingAttributionToken
    case networkError
    case errorResponseFromAppleAttribution
    case errorResponseFromASAAttribution
    case debugAttributionTokenReceived
    
    private func errorCodeDescription() -> String {
        switch self {
        case .unsupportedIOSVersion: return "Unfortunately, we're now only support iOS 14.3 and later."
        case .errorGeneratingAttributionToken: return "Could not generate on device attribution token."
        case .networkError: return "Network error."
        case .errorResponseFromAppleAttribution: return "Error response from apple servers. Please try again later."
        case .errorResponseFromASAAttribution: return "Internal service error. We will fix it soon!"
        case .debugAttributionTokenReceived: return "Everything configured properly, but you've sent a debug token."
        }
    }
    
    public func error(message: String? = nil) -> Error {
        var userInfo: [String: Any] = [NSLocalizedDescriptionKey: self.errorCodeDescription()]
        if let message = message {
            userInfo[NSLocalizedFailureReasonErrorKey] = message
        }

        return NSError(domain: String(describing: ASAAttribution.self),
                       code: self.rawValue,
                       userInfo: userInfo)
    }
}

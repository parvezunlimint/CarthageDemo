//
//  Request.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.10.2020.
//

import Foundation

struct Request: Codable {
    /**
     Request ID, should be unique for time period of 30 minutes
     */
    var id: String = UUID().uuidString
    /**
     Request attempt date and time up to milliseconds in ISO 8601 format (milliseconds is optional part)
     (example of format - yyyy-MM-dd'T'HH:mm:ss.SSS'Z')
     
     Should be current server time of request (UTC time) or shouldn't be more than +3 hours or less than -3 hours from current UTC time
     */
    var time: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter.string(from: Date())
    }()
}

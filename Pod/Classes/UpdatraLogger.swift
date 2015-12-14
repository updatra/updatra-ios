//
//  UpdatraLogger.swift
//  Pods
//
//  Created by Michael Seid on 12/13/15.
//
//

import Foundation

class UpdatraLogger{
    static let logger = UpdatraLogger()
    func log(s: String) {
        print("[Updatra] \(s)")
    }
    static func sharedInstance() -> UpdatraLogger{
        return UpdatraLogger.logger;
    }
}
//
//  Updatra.swift
//  Pods
//
//  Created by Michael Seid on 12/11/15.
//
//

import Foundation
import Alamofire
import SwiftyJSON

public class UpdatraDelegate {
    static let sharedInstance = UpdatraDelegate()
    var hasIdentified = false
    var appId: String?
    var identity: Identity? = Identity.load()
    let errorMsg = "Unsuccessful identifification, please ensure to have email, userId and firstName"
    let identityMsg = "Please make sure to identify the user"
    let apiBase = "https://api.updatra.com/edge/v1"
    let logger = UpdatraLogger.sharedInstance()
    
    static func sharedInstanceWithAppId(appId: String) -> UpdatraDelegate {
        sharedInstance.appId = appId
        return sharedInstance
    }
    
    public func identify(params: [String: String]) {
        if (!(params["email"] != nil || params["userId"] != nil)) {
            print("You need to specify either the email or the userId")
            return
        }
        let request = "\(apiBase)/app/\(appId!)/identify"
        Alamofire.request(.GET, request, parameters: params)
            .responseJSON { response in
                self.logger.log("\(response.request)")
                self.logger.log("\(response.data)")
                switch response.result {
                    case .Success(let json):
                        print("Success with JSON: \(json)")
                        let parsedJson = JSON(json)
                        if let id = parsedJson["id"].string {
                            Identity.create(id)
                        } else {
                            self.logger.log(self.errorMsg)
                        }
                    default:
                          self.logger.log(self.errorMsg)
                }
        }
    }
    
    public func addPushDeviceToken(id: String) {
        if let visitorId = identity?.id {
            let request = "\(apiBase)/app/\(appId!)/identify/device"
            Alamofire.request(.GET, request, parameters: ["id": visitorId, "device": ["ios": id]])
                .responseJSON { response in
                    self.logger.log("\(response.request)")
                    self.logger.log("\(response.data)")
                    switch response.result {
                        case .Success:
                            self.logger.log("Succesfully subscribed device")
                        default:
                            self.logger.log(self.errorMsg)
                    }
            }
        } else {
            print(identityMsg)
        }
    }
    
    public func showPresence() {
        if let visitorId = identity?.id {
            let request = "\(apiBase)/app/\(appId!)/identify/presence"
            Alamofire.request(.GET, request, parameters: ["id": visitorId, "device": "ios"])
                .responseJSON { response in
                    self.logger.log("\(response.request)")
                    self.logger.log("\(response.data)")
                    switch response.result {
                        case .Success:
                            self.logger.log("Succesfully shared presense")
                        default:
                            self.logger.log(self.errorMsg)
                    }
            }
        } else {
            print(identityMsg)
        }
    }
    
    public func recievedNotification(userInfo: [NSObject : AnyObject]) {
        if let updateId = userInfo["updatraUpdateId"] {
            if let visitorId = identity?.id {
                let seenRequest = "\(apiBase)/app/\(appId!)/update/\(updateId)/seen"
                Alamofire.request(.GET, seenRequest, parameters: ["id": visitorId])
                    .responseJSON { response in
                        self.logger.log("\(response.request)")
                        self.logger.log("\(response.data)")
                        switch response.result {
                            case .Success:
                                self.logger.log("Succesfully seen update")
                            default:
                                self.logger.log(self.errorMsg)
                        }
                }
                let clickRequest = "\(apiBase)/app/\(appId!)/update/\(updateId)/click"
                Alamofire.request(.GET, clickRequest, parameters: ["id": visitorId])
                    .responseJSON { response in
                        self.logger.log("\(response.request)")
                        self.logger.log("\(response.data)")
                        switch response.result {
                            case .Success:
                                self.logger.log("Succesfully clicked update")
                            default:
                                self.logger.log(self.errorMsg)
                        }
                }

            } else {
                logger.log(identityMsg)
            }

        }
    }
}


public func sharedInstanceWithAppId(appId: String) -> UpdatraDelegate {
    return UpdatraDelegate.sharedInstanceWithAppId(appId)
}

public func sharedInstance() -> UpdatraDelegate {
    return UpdatraDelegate.sharedInstance
}
//
//  Identity.swift
//  Pods
//
//  Created by Michael Seid on 12/10/15.
//
//

import Foundation

public class Identity{
    var id: String
    init(id: String) {
        self.id = id
    }
    static func create(id: String) -> Identity? {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(id, forKey: "Updatra-VistorId")
        print("Created and saved identity with id: \(id)")
        return Identity(id: id)
    }
    static func load() -> Identity? {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey("Updatra-VistorId")
        {
            print("Loaded id \(id)")
            return Identity(id: id)
        }
        else
        {
            return nil
        }
    }
    
    
}
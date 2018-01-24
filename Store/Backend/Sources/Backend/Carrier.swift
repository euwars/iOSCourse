//
//  Carrier.swift
//  Backend
//
//  Created by Farzad Nazifi on 24.01.18.
//

import Foundation
import Meow
import PromiseKit

class Carrier: Model {
    var _id = ObjectId()
    var name: String
    var faName: String
    
    init(name: String, faName: String) {
        self.name = name
        self.faName = faName
    }
    
    static func all() -> Promise<[Carrier]> {
        return Promise<[Carrier]>(.pending) { seal in
            do {
                let carriers = try Carrier.find()
                seal.fulfill(Array(carriers))
            }catch let err {
                seal.reject(err)
            }
        }
    }
    
    static func carrier(withName name: String) -> Promise<Carrier> {
        return Promise<Carrier>(.pending) { seal in
            do {
                if let carrier = try Carrier.findOne("name" == name) {
                    seal.fulfill(carrier)
                }else {
                    seal.reject(Store.Errors.objectNotFound(k: "\(self)"))
                }
            }catch let err {
                seal.reject(err)
            }
        }
    }
}

extension Store {
    func listCarriers() {
        do {
            let x = try Carrier.find()
            x.forEach { (carr) in
                print(carr.name)
            }
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

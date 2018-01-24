//
//  Order.swift
//  Backend
//
//  Created by Farzad Nazifi on 24.01.18.
//

import Foundation
import Meow
import PromiseKit

class Order: Model {
    var _id = ObjectId()
    var carrier: Reference<Carrier>
    var isPaid: Bool
    var paymentRefrence: String?
    var userName: String
    var creationDate: Date
    var paymentDate: Date?
    
    init(carrier: Reference<Carrier>, isPaid: Bool, paymentRefrence: String? = nil, userName: String, creationDate: Date, paymentDate: Date? = nil) {
        self.carrier = carrier
        self.isPaid = isPaid
        self.paymentRefrence = paymentRefrence
        self.userName = userName
        self.creationDate = creationDate
        self.paymentDate = paymentDate
    }
    
    static func createOrder(carrier: Carrier, userName: String) -> Promise<String> {
        return Promise<String>(.pending) { seal in
            do {
                let newOrder = Order(carrier: try Reference(to: carrier._id), isPaid: false, paymentRefrence: nil, userName: userName, creationDate: Date(), paymentDate: nil)
                try newOrder.save()
                seal.fulfill(newOrder._id.hexString)
            } catch let err {
                seal.reject(err)
            }
        }
    }
    
    static func userOrders(userName: String) -> Promise<[Order]> {
        return Promise<[Order]>(.pending) { seal in
            do {
            let orders = try Order.find("userName" == userName)
            seal.fulfill(Array(orders))
            } catch let err {
                seal.reject(err)
            }
        }
    }
}

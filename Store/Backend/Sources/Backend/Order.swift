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
    
    init(carrier: Reference<Carrier>, isPaid: Bool, paymentRefrence: String? = nil, userName: String, creationDate: Date) {
        self.carrier = carrier
        self.isPaid = isPaid
        self.paymentRefrence = paymentRefrence
        self.userName = userName
        self.creationDate = creationDate
    }
    
    static func order(withID id: String) -> Promise<Order> {
        return Promise<Order>(.pending) { seal in
            do {
                if let order = try Order.findOne("_id" == ObjectId(id)) {
                    seal.fulfill(order)
                }else {
                    seal.reject(Store.Errors.objectNotFound(k: "\(self)"))
                }
            }catch let err {
                seal.reject(err)
            }
        }
    }
    
    static func createOrder(carrier: Carrier, userName: String) -> Promise<String> {
        return Promise<String>(.pending) { seal in
            do {
                let newOrder = Order(carrier: try Reference(to: carrier._id), isPaid: false, paymentRefrence: nil, userName: userName, creationDate: Date())
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
    
    static func veryifyPayment(order: Order, paymentRefrence: String, userName: String) -> Promise<String> {
        return Promise<String>(.pending) { seal in
            do {
                if (order.paymentRefrence == nil) && order.userName == userName {
                    // Make sure paymentRefrence has not been used before
                    if try Order.count("paymentRefrence" == paymentRefrence, limitedTo: nil, skipping: nil) == 0 {
                        // safe to move forward
                        verifyPayir(paymentRefrence: paymentRefrence).done({ (verified) in
                            // Payment Verified
                            // Assing an inventory Item to user
                            if let optimalInventory = try InventoryItem.findOne("carrier" == order.carrier && "isActive" == true && "userName" == nil) {
                                // Optimal inventoy found
                                optimalInventory.isActive = false
                                optimalInventory.userName = userName
                                try optimalInventory.save()
                                
                                order.paymentRefrence = paymentRefrence
                                order.isPaid = true
                                try order.save()
                                
                                seal.fulfill(optimalInventory.code)
                            }else{
                                seal.reject(Store.Errors.outOfStock)
                            }
                        }).catch({ (err) in
                            seal.reject(err)
                        })
                    }else{
                        // reusing same payment refrence not allowed
                        seal.reject(Store.Errors.paymentVerificationFailed)
                    }
                }else{
                    // Order already has been processed
                    seal.reject(Store.Errors.notAllowed)
                }
            } catch let err {
                seal.reject(err)
            }
        }
    }
    
    static private func verifyPayir(paymentRefrence: String) -> Promise<Bool> {
        return Promise<Bool>(.pending) { seal in
            seal.fulfill(true)
            
            //            get(url: "https://pay.ir/payment/verify/api=APIHERE&transId=\(paymentRefrence)").done({ (result) in
            //                guard let status = result["status"].bool else {
            //                    seal.reject(Store.Errors.paymentVerificationFailed)
            //                    return
            //                }
            //
            //                if status {
            //                    seal.fulfill(true)
            //                }else{
            //                    seal.reject(Store.Errors.paymentVerificationFailed)
            //                }
            //
            //            }).catch({ (err) in
            //                seal.reject(err)
            //            })
        }
    }
    
    private static func get(url: String) -> Promise<[String: Any?]> {
        return Promise<[String: Any?]>(.pending) { seal in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
                if let hasData = data {
                    guard let jsonObj = try? JSONSerialization.jsonObject(with: hasData, options: []),
                        let json = jsonObj as? [String: Any] else {
                            seal.reject(Store.Errors.unkown)
                            return
                    }
                    seal.fulfill(json)

                }
                if let error = err {
                    seal.reject(error)
                }
                seal.reject(Store.Errors.unkown)
            })
            
            task.resume()
        }
    }
}

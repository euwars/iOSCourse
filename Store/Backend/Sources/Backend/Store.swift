//
//  Store.swift
//  Backend
//
//  Created by Farzad Nazifi on 24.01.18.
//

import Foundation
import Meow
import Kitura
import PromiseKit

class Store {
    
    public enum Errors: Error, LocalizedError {
        case objectNotFound(k: String)
        case inventoryEmpty
        case missingParameter(p: String)
        case missingBody
        case paymentVerificationFailed
        case notAllowed
        case outOfStock
        case unkown
        
        public var errorDescription: String? {
            return "\(self)"
        }
    }
    
    public let router = Router()
    
    init() throws {
        do {
            let mongoDB = try Server("mongodb://admin:iOSCourseShop@cluster0-shard-00-00-gipv3.mongodb.net:27017,cluster0-shard-00-01-gipv3.mongodb.net:27017,cluster0-shard-00-02-gipv3.mongodb.net:27017/admin?replicaSet=Cluster0-shard-0&ssl=true")
            Meow.init(mongoDB["shop"])
            
            router.all(nil, middleware: BodyParser())
            
            router.get("/carriers", handler: carriers)
            
            router.post("/order/new", handler: newOrder)
            router.get("/order/user", handler: userOrders)
            router.post("/order/obtainCode", handler: obtainCode)
            
            router.get("/inventory/user", handler: userItems)
        } catch let err {
            throw err
        }
    }
}

extension Store {
    
    func carriers(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        firstly {
            Carrier.all()
            }.done { (carriers) in
                response.send(json: carriers)
            }.catch { (err) in
                response.send(status: .notFound).send(" err: \(err.localizedDescription)")
        }
    }
    
    func newOrder(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        firstly {
            request.bodyVerify(parameters: ["userName", "carrierName"])
            }.then { (verified) -> Promise<Carrier> in
                return Carrier.carrier(withName: (request.body?.asJSON)!["carrierName"] as! String)
            }.then { (carrier) -> Promise<(Bool, Carrier)> in
                return InventoryItem.hasAvaliable(carrier: carrier)
            }.then { (avcar) -> Promise<String> in
                return Order.createOrder(carrier: avcar.1, userName: (request.body?.asJSON)!["userName"] as! String)
            }.done { (orderID) in
                response.send(json: ["orderID": orderID])
            }.catch { (err) in
                response.send(status: .failedDependency).send(" err: \(err.localizedDescription)")
        }
    }
    
    func userOrders(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        firstly {
            request.queryVerify(parameters: ["userName"])
            }.then { (verified) -> Promise<[Order]> in
                return Order.userOrders(userName: request.queryParameters["userName"]!)
            }.done { (orders) in
                response.send(json: orders)
            }.catch { (err) in
                response.send(status: .notFound).send(" err: \(err.localizedDescription)")
        }
    }
    
    func obtainCode(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        firstly {
            request.bodyVerify(parameters: ["userName", "paymentRefrence", "orderID"])
            }.then { (verified) -> Promise<Order> in
                return Order.order(withID: (request.body?.asJSON)!["orderID"] as! String)
            }.then { (order) -> Promise<String> in
                return Order.veryifyPayment(order: order, paymentRefrence: (request.body?.asJSON)!["paymentRefrence"] as! String, userName: (request.body?.asJSON)!["userName"] as! String)
            }.done { (code) in
                response.send(json: ["code": code])
            }.catch { (err) in
                response.send(status: .notAcceptable).send(" err: \(err.localizedDescription)")
        }
    }
    
    func userItems(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        firstly {
            request.queryVerify(parameters: ["userName"])
            }.then { (verified) -> Promise<[InventoryItem]> in
                return InventoryItem.userItems(userName: request.queryParameters["userName"]!)
            }.done { (items) in
                response.send(json: items)
            }.catch { (err) in
                response.send(status: .notFound).send(" err: \(err.localizedDescription)")
        }
    }
    
}

extension RouterRequest {
    func bodyVerify(parameters: [String]) -> Promise<Bool> {
        return Promise<Bool>(.pending) { seal in
            
            guard self.body?.asJSON != nil else {
                seal.reject(Store.Errors.missingBody)
                return
            }
            
            parameters.forEach({ (key) in
                guard ((self.body?.asJSON)![key] != nil) else {
                    seal.reject(Store.Errors.missingParameter(p: key))
                    return
                }
            })
            
            seal.fulfill(true)
        }
    }
    
    func queryVerify(parameters: [String]) -> Promise<Bool> {
        return Promise<Bool>(.pending) { seal in
            parameters.forEach { (key) in
                guard self.queryParameters[key] != nil else {
                    seal.reject(Store.Errors.missingParameter(p: key))
                    return
                }
            }
            
            seal.fulfill(true)
        }
    }
}

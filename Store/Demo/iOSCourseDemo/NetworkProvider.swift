//
//  NetworkProvider.swift
//  iOSCourseDemo
//
//  Created by Farzad Nazifi on 28.01.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import Foundation
import Moya


enum StoreService {
    case carriers
    case newOrder(userName: String, carrierName: String)
    case obtainCode(userName: String, orderID: String, paymentRefrence: String)
    case userInvenvoty(userName: String)
}

extension StoreService: TargetType {
    var baseURL: URL { return URL(string: "https://ioscoursestore.eu-gb.mybluemix.net")! }
    var path: String {
        switch self {
        case .carriers:
            return "/carriers"
        case .newOrder(_, _):
            return "/order/new"
        case .obtainCode:
            return "/order/obtainCode"
        case .userInvenvoty:
            return "/inventory/user"
        }
    }
    var method: Moya.Method {
        switch self {
        case .carriers, .userInvenvoty:
            return .get
        case .newOrder, .obtainCode:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .carriers: // Send no parameters
            return .requestPlain
        case .newOrder(let userName, let carrierName):
            return .requestParameters(parameters: ["userName": userName, "carrierName": carrierName], encoding: JSONEncoding.default)
        case .obtainCode(let userName, let orderID, let paymentRefrence):
            return .requestParameters(parameters: ["userName": userName, "orderID": orderID, "paymentRefrence": paymentRefrence], encoding: JSONEncoding.default)
        case .userInvenvoty(let userName):
            return .requestParameters(parameters: ["userName": userName], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

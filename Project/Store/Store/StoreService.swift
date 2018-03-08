//
//  Store.swift
//  Store
//
//  Created by Farzad Nazifi on 04.03.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import Foundation
import Moya

enum StoreService {
    case carriers
}

extension StoreService: TargetType {
    var baseURL: URL {
        return URL(string: "https://ioscoursestore.eu-gb.mybluemix.net")!
    }
    
    var path: String {
        return "/carriers"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

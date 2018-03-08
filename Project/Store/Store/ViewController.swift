//
//  ViewController.swift
//  Store
//
//  Created by Farzad Nazifi on 04.03.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let provider = MoyaProvider<StoreService>()
        provider.request(.carriers) { (result) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}


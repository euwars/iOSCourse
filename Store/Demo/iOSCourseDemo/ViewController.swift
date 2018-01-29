//
//  ViewController.swift
//  iOSCourseDemo
//
//  Created by Farzad Nazifi on 28.01.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class ViewController: UIViewController {
    
    var data: JSON?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let provider = MoyaProvider<StoreService>()
        
        provider.request(StoreService.carriers) { result in
            // do something with the result (read on for more details)
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let jsonObj = JSON(data)
                self.data = jsonObj
                self.tableView.reloadData()
                print(jsonObj)
            // do something in your app
            case let .failure(error):
                // TODO: handle the error == best. comment. ever.
                print("network req failed: \(error.localizedDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data != nil {
            return data!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarriersTableViewCell
        if data != nil {
            let cellObj = data![indexPath.row]
            print(cellObj)
            cell.setData(name: cellObj["name"].stringValue, faName: cellObj["faName"].stringValue)
        }

        return cell
    }
}

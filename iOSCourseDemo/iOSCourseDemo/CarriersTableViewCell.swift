//
//  CarriersTableViewCell.swift
//  iOSCourseDemo
//
//  Created by Farzad Nazifi on 28.01.18.
//  Copyright © 2018 Farzad Nazifi. All rights reserved.
//

import UIKit

class CarriersTableViewCell: UITableViewCell {
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(name: String, faName: String) {
        label1.text = name
        label2.text = faName
    }

}

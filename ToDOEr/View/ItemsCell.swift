//
//  ItemsCell.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 05.09.2022.
//

import UIKit

class ItemsCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    
    func updateView(string: String) {
        titleLbl.text = string
    }

}

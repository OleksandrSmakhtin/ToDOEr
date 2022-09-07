//
//  CategoryCell.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 05.09.2022.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    func updateView(string: String) {
        nameLbl.text = string
    }

}

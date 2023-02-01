//
//  CalendarCell.swift
//  J.I.M
//
//  Created by Julian Manaois on 1/31/23.
//

import Foundation
import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.lightGray
            } else {
                self.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
}


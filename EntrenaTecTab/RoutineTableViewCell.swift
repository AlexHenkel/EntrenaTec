//
//  RoutineTableViewCell.swift
//  EntrenaTecTab
//
//  Created by Javier Guajardo on 4/13/16.
//  Copyright © 2016 Alejandro Henkel. All rights reserved.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {

    @IBOutlet weak var outletEjercicio: UILabel!
    @IBOutlet weak var outletSubtitulo: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

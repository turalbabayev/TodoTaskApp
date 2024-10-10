//
//  TaskTableViewCell.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskMotivationMessage: UILabel!
    @IBOutlet weak var buttonDetailOutlet: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonDetailAction(_ sender: UIButton) {
    }
    
}

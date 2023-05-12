//
//  UserCard.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import UIKit

class UserCard: UITableViewCell {
    
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelNama: UILabel!
    
    @IBOutlet weak var imageProfil: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}

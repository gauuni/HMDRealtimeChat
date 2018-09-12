//
//  UserCell.swift
//  DemoSocketIOClient
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit

class UserCell: BaseTableViewCell {

    @IBOutlet private weak var imgViewAvatar: UIImageView!
    @IBOutlet private weak var lblUsername: UILabel!
    @IBOutlet private weak var imgViewStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func binding(username: String){
        lblUsername.text = username
    }
    
}

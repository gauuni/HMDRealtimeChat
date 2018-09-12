//
//  UITableViewExtension.swift
//  Fitness
//
//  Created by Nguyen Khoi Nguyen on 11/3/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import UIKit
import HMDMusicManager

extension UITableView{
    
    func reloadSongCell(with data: [PlaylistItemObject], playlistId: String, codeCountry: String = RootString.Player.noneCodeCountry){
        guard let indexPathsForVisibleRows = self.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in indexPathsForVisibleRows{
            let item = data[indexPath.row]
            guard let cell = self.cellForRow(at: indexPath) as? SongCell else{
                return
            }
            cell.updateIndicatorStatus(item: item, playlistId: playlistId, codeCountry: codeCountry)
        }
    }
}

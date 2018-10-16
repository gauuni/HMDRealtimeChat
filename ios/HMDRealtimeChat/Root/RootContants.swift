//
//  SohdaContants.swift
//  Sohda
//
//  Created by Duc Nguyen on 5/17/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation
import UIKit

// The enum of the storyboards in the app
enum RootStoryboard: String {
    case Invalid = "Invalid"
    case Main = "Main"
    case Dashboard = "Dashboard"
    case Playlists = "Playlists"
    case Songs = "Songs"
    case Files = "Files"
    case Settings = "Settings"
    case Player = "Player"
    case Search = "Search"
    case Library = "Library"
    case Tutorial = "Tutorial"
    
 }



enum RootNav: String {
    case Home = "RootNavigationHome"

}

enum RootVC: String {
    case LoginHome = "HomeScreenViewController"
}

enum RootNavigationPushAnimation: Int {
    case Default = 0
    case BottomTop = 1
    case TopBottom = 2
}





//
//  UIColor+Utilities.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Define color

extension UIColor{
    static let MainBoldColor : UIColor = UIColor.colorWithHexString(hex: "5F04C6")
    static let MainThinColor : UIColor =  UIColor.colorWithHexString(hex: "9A5DAE")
}

extension UIColor {
    
    
    static var naviColor: UIColor {
        return UIColor.colorWithHexString(hex: "4A4A4A")
    }
    static var tabbarColor: UIColor {
        return UIColor.colorWithHexString(hex: "9B9B9B")
    }
    static var tabbarActiveColor: UIColor {
        return UIColor.colorWithHexString(hex: "B26EFF")
    }
    static var contentColor: UIColor {
        return UIColor.colorWithHexString(hex: "9B9B9B")
    }
    static var lineColor: UIColor {
        return UIColor.colorWithHexString(hex: "E8E8E8")
    }
    static var bgCellFolderColor: UIColor {
        return UIColor.colorWithHexString(hex: "EAEAEA")
    }
    static var downloadTrackColor: UIColor {
        return UIColor.colorWithHexString(hex: "DCDCDC")
    }
    
    struct Dashboard {
        static var dashboardSectionColor: UIColor {
            return UIColor.colorWithHexString(hex: "848484")
        }
        static var dashboardGoogleColor: UIColor {
            return UIColor.colorWithHexString(hex: "306EAD")
        }
        static var dashboardDropboxColor: UIColor {
            return UIColor.colorWithHexString(hex: "4A90E2")
        }
        static var dashboardOneDriveColor: UIColor {
            return UIColor.colorWithHexString(hex: "02955F")
        }
        static var dashboardYeahColor: UIColor {
            return UIColor.colorWithHexString(hex: "708A9F")
        }
        static var dashboardOnlyAvalibleColor: UIColor {
            return UIColor.colorWithHexString(hex: "E30072")
        }
        static var dashboardITunesHColor: UIColor {
            return UIColor.colorWithHexString(hex: "00ACDE")
        }
        static var dashboardWifiColor: UIColor {
            return UIColor.colorWithHexString(hex: "8B8BFF")
        }
    }
    

//    static var wifi_ButtonHex: UIColor {
//        return UIColor.colorWithHexString(hex: "2287FD")
//    }
//    static var song_SingerHex: UIColor {
//        return UIColor.colorWithHexString(hex: "C4C4C4")
//    }
//    static var song_numListenHex: UIColor {
//        return UIColor.colorWithHexString(hex: "B7B7B7")
//    }
//    static var playlist_TitleHex: UIColor {
//        return UIColor.colorWithHexString(hex: "6E6E6E")
//    }
//    static var playlist_BgHeaderHex: UIColor {
//        return UIColor.colorWithHexString(hex: "E4E4E4")
//    }
//
}


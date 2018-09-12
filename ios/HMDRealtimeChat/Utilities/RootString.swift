//
//  RootString.swift
//  HoiNgu
//
//  Created by Khoi Nguyen on 3/6/18.
//  Copyright © 2018 Hamado. All rights reserved.
//

import UIKit

class RootString: NSObject {

    struct Tabbar {
        static let dashboardTitle = "Dashboard"
        static let playlistsTitle = "Playlists"
        static let songsTitle = "Songs"
        static let searchTitle = "Player"
        static let settingsTitle = "Settings"
    }
    
    struct DashBoard {
        static let titleDashboard = "Services"
        static let appName = "Dility Player"
        
        
        struct Clouds {
            static let titleCloud = "Clouds"
            static let connect = "Connect"
            static let disconnect = "Disconnect"
            static let establishConnect = "Could not establish connection"
            struct Methods {
                static let wifiTitle = "Wifi Transfer"
                static let wifiSubtitle = "Import music into the app through computer's web browser."
                static let driveTitle = "Google Drive"
                static let driveSubtitle = "Transfer music from your Google Drive account."
                static let playByGoogle = "Play from Google Drive"
                
                static let dropboxTitle = "Dropbox"
                static let dropboxSubtitle = "Transfer music from your Dropbox account."
                static let playByDropBox = "Play from Dropbox"
                
                static let onedriveTitle = "OneDrive"
                static let onedriveSubtitle = "Transfer music from your OneDrive account."
                static let playByOneDrive = "Play from OneDrive"
                
                static let boxDriveTitle = "Box"
                static let boxDriveSubtitle = "Browse and transfer music from your Box account."
                
                static let galleryTitle = "Gallery"
                static let gallerySubtitle = "Import videos and convert them to audio file extension files."
                static let galleryMessage = "Gallery Message"
                
                static let libraryTitle = "Music Library"
                static let librarySubtitle = "Transfer music from your music library in your phone."
                static let itunesTitle = "iTunes File Sharing"
                static let itunesSubtitle = "Sync library with music in Documents folder (accessible from iTunes)"
                static let yeahTitle = "Yeah Navigator"
                static let yeahSubtitle = "Discover music, albums and playlists you love with Yeah Navigator."
                static let katrinaTitle = "Katrina Channel"
                static let katrinaSubtitle = "Discover music, albums and playlists you love with Katrina Channel."
                static let top100Title = "Top ZNC Channel"
                static let top100Subtitle = "Discover music, albums and playlists you love with ZNC Channel."
                static let driveConnect = "Google Drive Connection"
                
            }
            
            
        }
        
        struct Stream {
            static let titleStream = "Streaming"
            static let youTube = "Tube"
            static let soundCloud = "Soundcloud"
            static let ktn = "KTN"
            static let znc = "ZNC"
            static let jamendo = "Jamendo"
            static let search  = "Search"
        }
        
        struct MusicTop100 {
            static let titleTop100 = "Music Top 100"
            static let shazam = "Shazam Top 100"
            static let itunes = "iTunes Top 100"
            static let spotify = "Spotify Top 100"
            static let deezer = "Deezer Top 100"
            static let zing = "Zing Top 100"
            static let countryCharts = "Country Top Charts"
        }
        
        struct Other {
            static let titleOther = "Others"
            static let wifi = "Wifi Transfer"
            static let library = "Music Library"
            static let iTuneShare = "iTunes File Sharing"
            static let setting = "Settings"
            
          
        }
    }
    
    struct Playlist {
        static let titleView = "Library"
        static let myPlaylist = "Playlists"
        static let editPlaylist = "Edit playlist"
        static let cancel = "Cancel"
        static let addNewPlaylist = "Add a new playlist"
        static let enterPlaylistName = "Enter your playlist name."
        
        struct actionToSong {
            static let addNew = ""
            static let delete = "Delete"
            static let edit = "Edit"
            static let update = "Update"
            static let changName = "Enter your name audio"
            static let convert = "Convert Now"
            static let name = "Audio name"
        }
    }
    

    
    struct Settings {
        
        static var  signOutButtonTitle: String { return "Sign Out" }
        
        static let privacyURL = "http://hamado-ltd.com/privacy.html"
        static let termURL = "http://hamado-ltd.com/toc.html"
        static let feedbackURL = "https://muzicfly.weebly.com/"
        static let appURL = "\(LinkApp)"
        static let shareAppText = "Hi,\nPlease check this awesome Dility Player app on the App Store: " + appURL
        static let advertisingSection = "Advertising"
        static let socialSection = "Social"
        static let privacySection = "Privacy"
        static let cloudSection = "Clouds"
        // advertising section
        static let removeAds = "Remove Ads"
        static let restore = "Restore"
        //social section
        static let help = "Help and question"
        static let rate = "Rate App"
        static let share = "Share App"
        static let term = "Term & Conditions"
        static let privacy = "Privacy"
        //cloud section
        static let googleConnect = "Connect with Google Drive"
         static let googleConnectSuccess = "Connect success with Google Drive"
        static let googleSignOut = "Signout Google Drive"
        
        static let dropBoxConnect = "Connect with Dropbox"
        static let dropBoxConnectSuccess = "Connect Success with Dropbox"
        static let dropBoxSignout = "Signout Dropbox"
        static let onedriveConnect = "Connect with OneDrive"
        static let onedriveConnectSuccess = "Connect Success with OneDrive"
        static let onedriveSignout = "Signout OneDrive"
        
        static let boxDriveConnect = "Connect with Box"
        static let boxDeiveConnectSuccess = "Connect Success with Box"
        static let boxDriveSignout = "Signout Box"
        static let cancelAuthorize = "Authorization flow was manually canceled by user!"
        static let alertLogout = "Are you sure you want to dissonnect ?"
        
        
    }
    
    struct EmptyStrings {
        static let transferEmpty = "No folder or audio file in here"
        static let downloadEmpty = "There is no audio in the queue. "
        static let songsEmpty = "List songs are empty\nPlease add songs from Transfer"
        static let songEmpty = "You have not added any songs to this playlist yet"
        static let libraryEmpty = "Sync songs to your device"
        static let searchEmpty = "No result was founded"
        static let lyricEmpty = "[00:00.00]Sorry, couldn't find lyrics for this song!"
        static let playlistEmpty = "There is no playlist here. Please add a playlist with your favorite songs"
    }
    
    struct AlertMessages {
        static let yes = "Yes"
        static let no = "No"
        static let noneItemSelected = "You should select at least one item"
        static let confirmDelete = "Are you sure to want to delete items?"
        static let addToPlaylistSuccessful = "Song(s) is added to playlist successful"
        static let songIsExsistedInPlaylist = "This songs is exsisted in playlist"
        static let chooseOption = "Please select an option"
       
        static let confirmDeletePlaylist = "Are you sure to want to delete this playlist and its contents"
        
        static let requiredName = "Playlist's name is required."
        
        static let exportCompletely = "Export Completely. You can view file at the playlist tab."
        static let convertErr = "There is a trouble to convert the audio file. Please try again later"
        static let checkErrorNetwork = "Please check your Internet connection!"
        static let disconnectServer = "Are you sure you want to close and disconnect the signal to the web server? "
        static let allowMusicLibrary =  "Please go to Settings to allow access Music Library"
        
        static let selectYourAlarm = "Please select your alarm time!"
    }
    
    struct Search{
        static let placeholderSearch = "Search: Song Title, Singers, Albums"
        static let hotSearch = "Hot Searches"
        static let searchHistory = "Search History"
        
        struct ScrollTabbarTitle {
            static let sounclound = "Sound Cloud"
            static let katrina = "Katrina"
            static let znc = "ZNC"
            static let jamendo = "Jamendo"
            static let youtube = "Tube"
        }
    }
    
    struct PlayerGroup {
        static let songGroup = "songoffline"
        static let onlineGroup = "online"
        
    }
    
    struct Player {
        static let namePlaylistDefault = "NOW PLAYING"
        static let playingFrom = "PLAYING FROM"
        static let sourceYoutube = "source=youtube"
        static let timeDefault = "00:00"
        static let noneCodeCountry = "noneCodeCountry"
        
        static let titleAlarm = "My Alarm"
        struct AlarmTime {
            static let endthis = "End of this song"
            static let time15min = "15 minutes"
            static let time20min = "20 minutes"
            static let time30min = "30 minutes"
            static let time1hour = "1 hour"
        }
    }
    
    struct Download {
        static let titleDownload = "Downloads"
        
    }
    
    
    struct Tutorial {
        static let howItWork = "HOW IT WORKS?"
        static let firstTutorial = "Firstly, you have to upload music (make sure it is legal or have rights to use them) to one of these cloud services from your computer."
        static let almostThere = "ALMOST THERE…"
        static let secondTutorial = "Next, please sign in into cloud services where your music is stored to enjoy and listen them offline. "
    }
    
    struct Youtube {
        
    }
    
    
    
}

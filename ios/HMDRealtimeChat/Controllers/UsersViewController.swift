//
//  UsersViewController.swift
//  DemoSocketIOClient
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit

class UsersViewController: RootViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var users = [String]()
    
    override func setDataWhenFirstLoad() {
        RootSocketClientManager.shared.socket.on(RootSocketClientManager.SocketEvents.online) { (data, ack) in
            if let username = data.first as? String{
                if RootAuthManager.sharedInstance.username == username { return }
                RootSocketClientManager.shared.showBanner(title: username + "is active now", style: .success)
                self.users.insert(username, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .left)
            }
        }
        
        RootSocketClientManager.shared.socket.on(RootSocketClientManager.SocketEvents.offline) { (data, ack) in
            if let username = data.first as? String{
                if RootAuthManager.sharedInstance.username == username { return }
                RootSocketClientManager.shared.showBanner(title: username + " is leaving now", style: .danger)
                let index = self.users.index(of: username)
                if let index = index{
                    self.users.remove(at: index)
                    let indexPath = IndexPath(row: index, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
            }
        }
    }
    
    override func setViewWhenDidLoad() {
        setupTableView()
        
        self.addTitleBarButton(position: .right, title: "Log out", target: self, action: #selector(logoutPressed))
    }
    

}

// MARK: - Initialize
extension UsersViewController{
    func setupTableView(){
        tableView.initialize(delegate: self)
        tableView.registerCellNibs(nibs: [UserCell.self])
    }
}

// MARK: - Actions
extension UsersViewController{
    @IBAction func logoutPressed(){
        RootSocketClientManager.shared.disconnect()
        RootLinker.sharedInstance.rootViewDeckController?.centerViewController = RootLinker.getViewController(storyboard: .Main, aClass: LoginViewController.self)
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: UserCell.self) as! UserCell
        cell.binding(username: users[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

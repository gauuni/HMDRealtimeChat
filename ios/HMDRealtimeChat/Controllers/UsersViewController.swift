//
//  UsersViewController.swift
//  DemoSocketIOClient
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

class UsersViewController: RootViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var users = [UserResponse]()
    
    override func setDataWhenFirstLoad() {
        RootSocketClientManager.shared.socket.on(RootSocketClientManager.SocketEvents.online) { (data, ack) in
            guard let dict = data.first as? NSDictionary else { return }
            guard let user = Mapper<UserResponse>().map(JSONObject: dict) else { return }
            
            if RootAuthManager.shared.id == user.id { return }
            let index = self.users.index{ $0.id == user.id }
            if index != nil { return }
            RootSocketClientManager.shared.showBanner(title: user.name + " is active now", style: .success)
            self.users.insert(user, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .left)
        }
        
        RootSocketClientManager.shared.socket.on(RootSocketClientManager.SocketEvents.offline) { (data, ack) in
            
            guard let dict = data.first as? NSDictionary else { return }
            guard let user = Mapper<UserResponse>().map(JSONObject: dict) else { return }
            
            if RootAuthManager.shared.id == user.id { return }
            RootSocketClientManager.shared.showBanner(title: user.name + " is leaving now", style: .danger)
            let index = self.users.index{ $0.id == user.id }
            if let index = index{
                self.users.remove(at: index)
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
                
            
        }
        
        RootSocketClientManager.shared.socket.on(RootAuthManager.shared.id) { (data, ack) in
            
            guard let dict = data.first as? NSDictionary else { return }
            guard let message = Mapper<MessageResponse>().map(JSONObject: dict) else { return }
            let index = self.users.index{ $0.id == message.senderId }
            
            if let index = index{
                let user = self.users[index]
                user.numberOfMessages += 1
                user.channelId = message.channelId
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }

        }
    }
    
    override func setViewWhenDidLoad() {
        setupTableView()
        fetchUsers()
        
        self.addTitleBarButton(position: .right, title: "Log out", target: self, action: #selector(logoutPressed))
    }
    

}

// MARK: - Initialize
extension UsersViewController{
    func setupTableView(){
        tableView.initialize(delegate: self)
        tableView.registerCellNibs(nibs: [UserCell.self])
    }
    
    func fetchUsers(){
        RootAPI.fetchOnlineUsers { (response) in
            if let users = response?.data{
                self.users = users.filter{ $0.id != RootAuthManager.shared.id }
                self.tableView.reloadData()
            }
        }
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
        cell.binding(username: users[indexPath.row].name, count: users[indexPath.row].numberOfMessages)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        if user.channelId.length != 0{
            let vc = RootLinker.getViewController(storyboard: .Main, aClass: ChatViewController.self) as! ChatViewController
            vc.receiver = user.id
            vc.channelId = user.channelId
            self.pushVC(vc: vc)
            return
        }
        
        RootAPI.createChannel(senderId: RootAuthManager.shared.id, receiverId: user.id
        ) { (response) in
            if let channelId = response?.data{
                let vc = RootLinker.getViewController(storyboard: .Main, aClass: ChatViewController.self) as! ChatViewController
                vc.receiver = user.id
                vc.channelId = channelId
                self.pushVC(vc: vc)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

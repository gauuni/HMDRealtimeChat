//
//  ChatViewController.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import AudioToolbox
import ObjectMapper

class ChatViewController: RootViewController {
    
    //MARK: Properties
    @IBOutlet var inputBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override var inputAccessoryView: UIView? {
        get {
            self.inputBar.frame.size.height = self.barHeight
            self.inputBar.clipsToBounds = true
            return self.inputBar
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    var items = [MessageResponse]()
    let imagePicker = UIImagePickerController()
    let barHeight: CGFloat = 50
    var receiver: String!
    var channelId: String!
    
    override func setDataWhenFirstLoad() {
        
    }
    
    override func setViewWhenDidLoad() {        
        
        self.customization()
        self.fetchData()
        
        RootAPI.join(userId: RootAuthManager.shared.id, channelId: self.channelId) { (response) in
            RootSocketClientManager.shared.socket.on(self.channelId) { (data, ack) in
                
                guard let dict = data.first as? NSDictionary else { return }
                guard let message = Mapper<MessageResponse>().map(JSONObject: dict) else { return }
                if message.receiverId == RootAuthManager.shared.id{
                    self.playSound()
                }
                
                self.items.append(message)
                self.tableView.insertRows(at: [IndexPath(row: self.items.count-1, section: 0)], with: .none)
            }
        }
        
        
    }
    
    func playSound()  {
        var soundURL: NSURL?
        var soundID:SystemSoundID = 0
        let filePath = Bundle.main.path(forResource: "newMessage", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    //MARK: ViewController lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.inputBar.backgroundColor = UIColor.clear
        self.view.layoutIfNeeded()
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        RootSocketClientManager.shared.socket.off(self.channelId)
    }

}

// MARK: - Initialize
extension ChatViewController{

    func customization() {
        self.imagePicker.delegate = self
        self.tableView.estimatedRowHeight = self.barHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset.bottom = self.barHeight
        self.tableView.scrollIndicatorInsets.bottom = self.barHeight
        self.navigationItem.title = receiver
        
        tableView.registerCellNibs(nibs: [SenderCell.self,
                                          ReceiverCell.self])
   
    }
    
    //Downloads messages
    func fetchData() {
    
    }
}

// MARK: - Actions
extension ChatViewController{
    @IBAction func userPressed(){
        RootLinker.sharedInstance.rootViewDeckController?.openLeftNavigation()
    }
    
    
    
    
    
    //Hides current viewcontroller
    @objc func dismissSelf() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
    func animateExtraButtons(toHide: Bool)  {
        switch toHide {
        case true:
            self.bottomConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.inputBar.layoutIfNeeded()
            }
        default:
            self.bottomConstraint.constant = -50
            UIView.animate(withDuration: 0.3) {
                self.inputBar.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func showMessage(_ sender: Any) {
        self.animateExtraButtons(toHide: true)
    }
    
    @IBAction func selectGallery(_ sender: Any) {
        self.animateExtraButtons(toHide: true)

        
    }
    
    @IBAction func selectCamera(_ sender: Any) {
        self.animateExtraButtons(toHide: true)

    }
    
    @IBAction func showOptions(_ sender: Any) {
        self.animateExtraButtons(toHide: false)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if let text = self.inputTextField.text {
            if text.count > 0 {
                
                RootAPI.publish(channelId: self.channelId, senderId: RootAuthManager.shared.id, receiverId: receiver, message: text) { (response) in
                    
                }
                self.inputTextField.text = ""
            }
        }
    }
    
    //MARK: NotificationCenter handlers
    @objc func showKeyboard(notification: Notification) {
        if let frame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.tableView.contentInset.bottom = height
            self.tableView.scrollIndicatorInsets.bottom = height
            if self.items.count > 0 {
                self.tableView.scrollToRow(at: IndexPath.init(row: self.items.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.items[indexPath.row]
        if message.senderId == RootAuthManager.shared.id{
            let cell = tableView.dequeueReusableCell(cellClass: ReceiverCell.self) as! ReceiverCell
            
            cell.clearCellData()
            cell.message.text = message.content

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(cellClass: SenderCell.self) as! SenderCell
        cell.clearCellData()
        cell.message.text = message.content
        
        if indexPath.row != 0{
            let previousMessage = self.items[indexPath.row-1]
            if previousMessage.senderId == message.senderId{
                cell.profilePic.isHidden = true
            }else{
                cell.profilePic.isHidden = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.inputTextField.resignFirstResponder()
//        switch self.items[indexPath.row].type {
//        case .photo:
//            if let photo = self.items[indexPath.row].image {
//                let info = ["viewType" : ShowExtraView.preview, "pic": photo] as [String : Any]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showExtraView"), object: nil, userInfo: info)
//                self.inputAccessoryView?.isHidden = true
//            }
//        case .location:
//            let coordinates = (self.items[indexPath.row].content as! String).components(separatedBy: ":")
//            let location = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(coordinates[0])!, longitude: CLLocationDegrees(coordinates[1])!)
//            let info = ["viewType" : ShowExtraView.map, "location": location] as [String : Any]
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showExtraView"), object: nil, userInfo: info)
//            self.inputAccessoryView?.isHidden = true
//        default: break
//        }
    }
}

extension ChatViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

extension ChatViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
//            self.composeMessage(type: .photo, content: pickedImage)
//        } else {
//            let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//            self.composeMessage(type: .photo, content: pickedImage)
//        }
//        picker.dismiss(animated: true, completion: nil)
    }
}


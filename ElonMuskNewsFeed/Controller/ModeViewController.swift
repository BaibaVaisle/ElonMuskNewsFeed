//
//  ModeViewController.swift
//  ElonMuskNewsFeed
//
//  Created by baiba.vaisle on 02/09/2021.
//

import UIKit

class ModeViewController: UIViewController {

    
    @IBOutlet weak var openSettingsButton: UIButton!
    @IBOutlet weak var closedButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()
        closedButton.layer.cornerRadius = 6
        textLabel.layer.cornerRadius = 6
        openSettingsButton.layer.cornerRadius = 6
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openSettingsTapped(_ sender: Any) {
        openSetting()
    }
    
    func setLabelText(){
        var text = "Unable to specify IU style"
        if self.traitCollection.userInterfaceStyle == .dark{
            text = "Dark Mode is ON\nGo to Settings/Developer if you would like\nto change to Light Mode."
        }else{
            text = "Light Mode is On\nGo to Settings/Developer if you would like\nto change to Dark Mode."
        }
        textLabel.text = text
    }
    
    func openSetting(){
        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingURL){
            UIApplication.shared.open(settingURL, options: [:]) { success in
                print("success: ", success)
            }
        }
    }
    
}//end class
    
extension ModeViewController{
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setLabelText()
    }
}



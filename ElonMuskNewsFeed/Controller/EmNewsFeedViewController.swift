//
//  EmNewsFeedViewController.swift
//  ElonMuskNewsFeed
//
//  Created by baiba.vaisle on 28/08/2021.
//

import UIKit
import Gloss

class EmNewsFeedViewController: UIViewController {

    var items: [Item] = []
    //var searchResult = "Elon Mask"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        activityIndicatorView.isHidden = true
               handleGetData()
    }
    
    func activityIndicator(animated: Bool){
            DispatchQueue.main.async {
                if animated{
                    self.activityIndicatorView.isHidden = false
                    self.activityIndicatorView.startAnimating()
                }else{
                    self.activityIndicatorView.isHidden = true
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    
    @IBAction func infoBarItem(_ sender: Any) {
        basicAlert(title: "News Feed Info!", message: "Press plane to fetch Elon Musk News Feed articles.")
    }
    @IBAction func getDataTapped(_ sender: Any) {
        self.activityIndicator(animated: true)
        handleGetData()
    }
    
    func handleGetData(){
            self.activityIndicator(animated: true)
            let jsonUrl = "https://newsapi.org/v2/everything?q=Elon Musk&from=2021-08-01&to=2021-08-30&sortBy=popularity&apiKey=5e39034a500c4ca8b3549c11f7fba665"
            
            guard let url = URL(string: jsonUrl) else {return}
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { data, response, err in
                
    //            print("response: ", response as Any)
                if let err = err {
                    self.basicAlert(title: "Error!", message: "\(err.localizedDescription)")
                }
                
                guard let data = data else {
                    self.basicAlert(title: "Error!", message: "Something went wrong, no data")
                    return
                }
                
                do{
                    if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        print("dictData:", dictData)
                        self.populateData(dictData)
                    }
                }catch{
                    
                }

            }
            task.resume()
     
        }
        
    func populateData(_ dict: [String: Any]){
            guard let responseDict = dict["articles"] as? [Gloss.JSON] else {
                return
            }
            
            items = [Item].from(jsonArray: responseDict) ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator(animated: false)
            }
            
        }

}


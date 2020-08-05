//
//  SecondViewController.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit;

class SecondViewController: UIViewController {
    @IBOutlet var displayDataLabel: UILabel!
    
    var recievingString = ""
    var movieInfo = "uninitialized"
    /// To Do: Connect the UI to the fetcher
    /// Requests the movie from the TMDB API
    /// - Returns: URLSession JSON info
    func requestData() -> SearchResponse! {
        var results: SearchResponse!
        let baseURL =  "https://api.themoviedb.org/3/search/movie?api_key=a14dfef12046c0910a5fc5367d18b5ab&language=en-US&query=\(recievingString)&page=1&include_adult=false"
        print("Data Requested...")
        let convertedURL = URL(string: baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        URLSession.shared.dataTask(with: convertedURL!) { (data, response, err) in
            do {
//            self.movieInfo = String(data: data!, encoding: .utf8)!
                let decoder = JSONDecoder()
                let decodedInfo = try decoder.decode(SearchResponse.self, from: data!)
                results = decodedInfo
            } catch let error as NSError {
                print(error)
            }
//            print(self.movieInfo)

        }.resume()
        return results
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = requestData()
        print(data?.results[0] ?? "no data")
        displayDataLabel.text = recievingString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

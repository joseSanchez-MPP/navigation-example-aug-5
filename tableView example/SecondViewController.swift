//
//  SecondViewController.swift
//  tableView example
//
//  Created by jose sanchez on 8/4/20.
//  Copyright © 2020 jose sanchez. All rights reserved.
//

import UIKit;
import AVKit
import AVFoundation

class SecondViewController: UIViewController {
    @IBOutlet var introView: UIView!
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
    func playVid() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        let data = requestData()
//        print(data?.results[0] ?? "no data")
        displayDataLabel.text = recievingString
        
    //here's the intro portion
        
        guard let url = URL(string: "https://r3---sn-vgqsrn7s.googlevideo.com/videoplayback?expire=1596675861&ei=tAIrX9TXOJfYhgbG46ygCQ&ip=23.236.219.63&id=o-AKjlJCuMKWgMgF3aBOon99XXW_O_Lk7ff10B6rkLqGrJ&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&gir=yes&clen=2132035&ratebypass=yes&dur=31.045&lmt=1496585479931585&fvip=3&fexp=23883098&c=WEB&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAL0t4HzP6blkRXbYN9lP5izGzfcOvoRoEIZxB_ETEiw_AiAz1SHkFUAd9-2xBL0aToGU9Bv6UjqbyWEzOd-7cxnUaw%3D%3D&redirect_counter=1&rm=sn-ab5e7s7s&req_id=6dfe3233d54da3ee&cms_redirect=yes&ipbypass=yes&mh=Cn&mip=2601:240:10e:4c82:55cd:14a8:c2a4:377&mm=31&mn=sn-vgqsrn7s&ms=au&mt=1596654231&mv=m&mvi=3&pl=26&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIgB-IqJw6GiMmy8lSSUuLDcW_kq82Rjk0EHtskbBf2XsMCIQDokbJYW7jgBFGqJt4MgPkXxE9iSO65uk_Ibg5cCYM2DQ%3D%3D") else {
            return
        }
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = introView.frame
        introView.layer.addSublayer(playerLayer)
        
        // Modally present the player and call the player's play() method when complete.
          player.play()
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

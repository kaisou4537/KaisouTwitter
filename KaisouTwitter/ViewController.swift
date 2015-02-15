//
//  ViewController.swift
//  KaisouTwitter
//
//  Created by 佐々木 健 on 2015/01/18.
//  Copyright (c) 2015年 ssk. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickButton(sender: AnyObject) {
        doTwitter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Twitter OAuth認証
    func doTwitter(){
        let oauth = OAuthSwift(
            consumerKey:    Twitter["consumerKey"]!,
            consumerSecret: Twitter["consumerSecret"]!,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        
        // 通信開始
        oauth.start()
        
    }
    
    // callback したurl
    // class funcとつけると静的メソッド
    class func handleOpenURL(url: NSURL) {
        println("OK!!")
//        let notification = NSNotification(name: CallbackNotification.notificationName, object: nil,
//            userInfo: [CallbackNotification.optionsURLKey: url])
//        NSNotificationCenter.defaultCenter().postNotification(notification)
        
        
        // urlからパラメータを作成
        var param : Dictionary<String, String> = Dictionary<String, String>()

        let oauth = OAuthSwift(
            consumerKey:    Twitter["consumerKey"]!,
            consumerSecret: Twitter["consumerSecret"]!,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )

        oauth.postAccessTokenWithRequestToken(url)
    }

}


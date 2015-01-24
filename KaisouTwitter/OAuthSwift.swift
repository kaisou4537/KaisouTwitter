//
//  OAuthSwift.swift
//  KaisouTwitter
//
//  Created by 佐々木 健 on 2015/01/18.
//  Copyright (c) 2015年 ssk. All rights reserved.
//

import Foundation

class OAuthSwift{
    
    var dataEncoding: NSStringEncoding = NSUTF8StringEncoding
    
    var data : NSMutableData? = nil
    
    var consumer_key: String
    var consumer_secret: String
    var request_token_url: String
    var authorize_url: String
    var access_token_url: String
    
    // コンストラクタ
    init(consumerKey: String, consumerSecret: String, requestTokenUrl: String, authorizeUrl: String, accessTokenUrl: String){
        self.consumer_key = consumerKey
        self.consumer_secret = consumerSecret
        self.request_token_url = requestTokenUrl
        self.authorize_url = authorizeUrl
        self.access_token_url = accessTokenUrl
//        self.client = OAuthSwiftClient(consumerKey: consumerKey, consumerSecret: consumerSecret)
    }
    
    func start() -> Void{
        //  POST& https://api.twitter.com/oauth/request_token&
        // oauth_consumer_key=CXubzXLR2vzqbCf1d9maSJ4ob
        // &oauth_nonce=3a2475c1d46d73c1802c01254660b8b0
        // &oauth_signature_method=HMAC-SHA1
        // &oauth_timestamp=1421590564
        // &oauth_version=1.0
        // &oauth_callback="oauth-swift://"
        
        let twitterURL : NSURL = NSURL(string: "https://api.twitter.com/oauth/request_token")!
//        let twitterURL : NSURL = NSURL(string: "http://www5471up.sakura.ne.jp/php/postcheck.php")!
        
        // request
        var request : NSMutableURLRequest = NSMutableURLRequest(URL: twitterURL);
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        // postData
//        let params : String =
//            "oauth_consumer_key=" + self.consumer_key + // コンシュマーキー
//            "&oauth_nonce=" + (NSUUID().UUIDString as NSString).substringToIndex(8) + // ランダムな文字列
////            "&oauth_signature=FMLpHBmLuFoErizdG3mA6V4%2B4cM%3D" +
//            "&oauth_signature_method=HMAC-SHA1" + // Twitterでは固定
//            "&oauth_timestamp=" + String(Int64(NSDate().timeIntervalSince1970)) + // Unixタイムスタンプ
//            "&oauth_version=1.0" +
////            "&oauth_version=1.0" +
//        "&oauth_callback=oob"
////            "&oauth_callback=oauth-swift://"

        
//        let params : String =
//        // コールバックだけ知っておく
////            "oauth_callback=oob" +
//            "oauth_consumer_key=" + self.consumer_key + // コンシュマーキー
//            "&oauth_nonce=" + (NSUUID().UUIDString as NSString).substringToIndex(8) + // ランダムな文字列
//            "&oauth_signature_method=HMAC-SHA1" + // Twitterでは固定 暗号化アルゴリズム名
//            //            "&oauth_signature=FMLpHBmLuFoErizdG3mA6V4%2B4cM%3D" +
//            "&oauth_timestamp=" + String(Int64(NSDate().timeIntervalSince1970)) + // Unixタイムスタンプ
//            "&oauth_version=1.0"


        // 足りないこと
        // sigunatureを作成していない
        // 最終的にリクエストするのは下記文字列
//        "OAuth oauth_callback=\"swift-oauth%3A%2F%2Fswift-oauth%2F\", oauth_consumer_key=\"CXubzXLR2vzqbCf1d9maSJ4ob\", oauth_nonce=\"46B623F4\", oauth_signature=\"%2Brx8F1ofGHhQe0iN%2Ff7MArz05F4%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1422107013\", oauth_version=\"1.0\""

        
        var param = Dictionary<String, String>()
        // バージョン
        param["oauth_version"] = "1.0"
        // 証明書アルゴリズム(Twitterでは固定)
        param["oauth_signature_method"] = "HMAC-SHA1"
        // ConsumerKey
        param["oauth_consumer_key"] = self.consumer_key
        // Unixタイムスタンプ
        param["oauth_timestamp"] = String(Int64(NSDate().timeIntervalSince1970))
        // ランダムな文字列
        param["oauth_nonce"] = (NSUUID().UUIDString as NSString).substringToIndex(8)
        // コールバック
        param["oauth_callback"] = "oauth-swift://"

        param["oauth_signature"] = self.oauthSignatureForMethod("POST", url: twitterURL, parameters: param)
        
        
        var authorizationParameterComponents = urlEncodedQueryStringWithEncoding(param).componentsSeparatedByString("&") as [String]
        authorizationParameterComponents.sort { $0 < $1 }

        
        var headerComponents = [String]()
        for component in authorizationParameterComponents {
            let subcomponent = component.componentsSeparatedByString("=") as [String]
            if subcomponent.count == 2 {
                headerComponents.append("\(subcomponent[0])=\"\(subcomponent[1])\"")
            }
        }
        print("OAuth " + ", ".join(headerComponents))
        
        
        
        request.setValue("OAuth " + ", ".join(headerComponents), forHTTPHeaderField: "Authorization")

        
        
        
        let params : String =
        // コールバックだけ知っておく
        //            "oauth_callback=oob" +
        "oauth_consumer_key=" + self.consumer_key + // コンシュマーキー
        "&oauth_nonce=" + (NSUUID().UUIDString as NSString).substringToIndex(8) + // ランダムな文字列
        "&oauth_signature_method=HMAC-SHA1" + // Twitterでは固定 暗号化アルゴリズム名
        //            "&oauth_signature=FMLpHBmLuFoErizdG3mA6V4%2B4cM%3D" +
        "&oauth_timestamp=" + String(Int64(NSDate().timeIntervalSince1970)) + // Unixタイムスタンプ
        "&oauth_version=1.0"

        
//        request.HTTPBody = params.dataUsingEncoding(dataEncoding)
        
        // 認証エラーが起きてる
        // 多分querystringが間違ってるんだよね・・・
        // 流れとして request_token発行 -> ouath_token取得 -> authrize_request投げる -> access_token取得
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            
            response, data, error in
            
            println("")
            println("")
            println("")
            println("")
            println("")
            println("response!!!!")
            println("")
            println("")
            println("")
            println("")
            println("")
            if(error != nil){
                println("認証エラー！")
                println(error.description)
            }
             print(NSString(data: data, encoding: self.dataEncoding)!)
        }
        
//        // まずPOSTで送信したい情報をセット。
//        let str : String = "name=taro&pw=tarospw"
//        let strData : NSData? = str.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        
//        var url : NSURL = NSURL(string: "http://hoge.com/api.php")!
//        var request : NSMutableURLRequest = NSMutableURLRequest(URL: url)
//        
//        // この下二行を見つけるのに、少々てこずりました。
//        request.HTTPMethod = "POST"
//        request.HTTPBody = strData
//        
//        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
//        
//        var dic = NSJSONSerialization.JSONObjectWithData(data!, options:nil, error: nil) as NSDictionary

    }
    
    // NSURLConnectionDelegate
//    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
//        println("didReceiveData")
//    }
//    
//    // NSURLConnectionDelegate
//    func connectionDidFinishLoading(connection: NSURLConnection!)
//    {
//        println("connectionDidFinishLoading")
//    }
    
    // サーバからレスポンスを受け取ったときのデリゲート
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data! = NSMutableData()
    }
    
    // サーバからデータが送られてきたときのデリゲート
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data!.appendData(data)
    }
    
    // データロードが完了したときのデリゲート
    func connectionDidFinishLoading(connection: NSURLConnection!){
        // バイナリデータが発行される
        let html : String = NSString(data: self.data!, encoding: NSUTF8StringEncoding)!
        // コンソールに出力
        println(html)
        
    }
    
    
    func oauthSignatureForMethod(method: String, url: NSURL, parameters: Dictionary<String, String>) -> String {
//        var tokenSecret: NSString = ""
//        tokenSecret = credential.oauth_token_secret.urlEncodedStringWithEncoding(dataEncoding)
//        
//        let encodedConsumerSecret = credential.consumer_secret.urlEncodedStringWithEncoding(dataEncoding)
        
        let signingKey : String = "\(self.consumer_secret)&"
        let signingKeyData = signingKey.dataUsingEncoding(dataEncoding)
        
        
        
        var parameterComponents = urlEncodedQueryStringWithEncoding(parameters).componentsSeparatedByString("&") as [String]
        parameterComponents.sort { $0 < $1 }
        
        
        
        
        
        // oauth_callback=swift-oauth%3A%2F%2Fswift-oauth%2F&oauth_consumer_key=CXubzXLR2vzqbCf1d9maSJ4ob&oauth_nonce=57CC0FC2&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1422107956&oauth_version=1.0
        //oauth_callback=swift-oauth://swift-oauth/&oauth_consumer_key=CXubzXLR2vzqbCf1d9maSJ4ob&oauth_nonce=57CC0FC2&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1422107956&oauth_version=1.0
        let parameterString = "&".join(parameterComponents)
        
        //oauth_callback%3Dswift-oauth%253A%252F%252Fswift-oauth%252F%26oauth_consumer_key%3DCXubzXLR2vzqbCf1d9maSJ4ob%26oauth_nonce%3DE49FB4DD%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1422108119%26oauth_version%3D1.0"
        //oauth_callback=swift-oauth%3A%2F%2Fswift-oauth%2F&oauth_consumer_key=CXubzXLR2vzqbCf1d9maSJ4ob&oauth_nonce=E49FB4DD&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1422108119&oauth_version=1.0"
        let encodedParameterString = urlEncodedStringWithEncoding(parameterString)
        
        let encodedURL = urlEncodedStringWithEncoding(url.absoluteString!)
        
        let signatureBaseString = "\(method)&\(encodedURL)&\(encodedParameterString)"
        let signatureBaseStringData = signatureBaseString.dataUsingEncoding(dataEncoding)
        
        return SHA1DigestWithKey(signatureBaseString, key: signingKey).base64EncodedStringWithOptions(nil)
    }

    func urlEncodedQueryStringWithEncoding(params:Dictionary<String, String>) -> String {
        var parts = [String]()
        
        for (key, value) in params {
            let keyString = urlEncodedStringWithEncoding(key)
            let valueString = urlEncodedStringWithEncoding(value)
            let query = "\(keyString)=\(valueString)" as String
            parts.append(query)
        }
        
        return "&".join(parts) as String
    }

    func urlEncodedStringWithEncoding(str: String) -> String {
        let charactersToBeEscaped = ":/?&=;+!@#$()',*" as CFStringRef
        let charactersToLeaveUnescaped = "[]." as CFStringRef
        
        var raw: NSString = str
        
        let result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, raw, charactersToLeaveUnescaped, charactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(dataEncoding)) as NSString
        
        return result
    }
    
    func SHA1DigestWithKey(base: String, key: String) -> NSData {
        let str = base.cStringUsingEncoding(dataEncoding)
        let strLen = UInt(base.lengthOfBytesUsingEncoding(dataEncoding))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        let keyStr = key.cStringUsingEncoding(NSUTF8StringEncoding)
        let keyLen = UInt(key.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), keyStr!, keyLen, str!, strLen, result)
        
        return NSData(bytes: result, length: digestLen)
    }


    
}

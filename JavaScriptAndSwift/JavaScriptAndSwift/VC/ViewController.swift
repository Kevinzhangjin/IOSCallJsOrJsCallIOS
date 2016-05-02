//
//  ViewController.swift
//  JavaScriptAndSwift
//
//  Created by huangyibiao on 15/10/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

import JavaScriptCore

@objc protocol JavaScriptSwiftDelegate: JSExport {
  
    func callSystemCamera();
  
    func showAlert(title: String, msg: String);

    func callWithDict(dict: [String: AnyObject])

    func jsCallObjcAndObjcCallJsWithDict(dict: [String: AnyObject]);
    
    func getInfo();

}

@objc class JSObjCModel: NSObject, JavaScriptSwiftDelegate {
    
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    //JS中的button调用Swift中的方法
    func callSystemCamera() {
      
        //Swift在调用JS中的方法
        let jsFunc = self.jsContext?.objectForKeyedSubscript("jsFunc");
        jsFunc?.callWithArguments([]);
    }
    
    
    func showAlert(title: String, msg: String) {
    
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
       
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            self.controller?.presentViewController(alert, animated: true, completion: nil)
     
        }
    }

    // JS调用了我们的方法
    func callWithDict(dict: [String : AnyObject]) {
    
    }

    // JS调用了我们的就去
    func jsCallObjcAndObjcCallJsWithDict(dict: [String : AnyObject]) {
        
        let jsParamFunc = self.jsContext?.objectForKeyedSubscript("jsParamFunc");
        let dict = NSDictionary(dictionary: ["age": 18, "height": 168, "name": "lili"])
        jsParamFunc?.callWithArguments([dict])
    
    }
    
    func getInfo(){
        print("dddfadfadfafdadf")
    }
    
    
}

class ViewController: UIViewController, UIWebViewDelegate {
 
    var webView: UIWebView!
    var jsContext: JSContext?
  
//    2 @property WebViewJavascriptBridge* bridge;

 
    override func viewDidLoad() {
      
    super.viewDidLoad()

        self.webView = UIWebView(frame: self.view.bounds);
        self.view.addSubview(self.webView)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true;
        let url = NSBundle.mainBundle().URLForResource("chart", withExtension: "html")
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
        
    }
    

    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlstr = request.URL?.absoluteString
        
        if  urlstr == nil {
            return true
        }
        
        let arry = urlstr!.componentsSeparatedByString("ios://jwzhangjie")
        
        if arry.count > 1 {
            print("包含  : \(arry[1])")
        } else {
            print("不包含: urlstr")
        }
        
        
        
        
        
        return true
    }
    
    
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        
        let context = webView.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
        let model = JSObjCModel()
        model.controller = self
        model.jsContext = context
        self.jsContext = context
          
        // 这一步是将OCModel这个模型注入到JS中，在JS就可以通过OCModel调用我们公暴露的方法了。
        self.jsContext?.setObject(model, forKeyedSubscript: "OCModel")
        let url = NSBundle.mainBundle().URLForResource("chart", withExtension: "html")
        self.jsContext?.evaluateScript(try? String(contentsOfURL: url!, encoding: NSUTF8StringEncoding));
          

        self.jsContext?.exceptionHandler = {
            (context, exception) in
            print("exception @", exception)
          }
        }
    
    
    //OC调用send给JS发消息
    func sendMessage(sender:AnyObject){
        
        
    }
    
    //OC调用callHandler给JS发消息
    func  callHandler(sender:AnyObject){
        
        
        
    }
    
    
    
  
}


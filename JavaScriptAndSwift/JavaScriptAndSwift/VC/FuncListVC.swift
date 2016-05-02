//
//  FuncListVC.swift
//  JavaScriptAndSwift
//
//  Created by tyApple2014 on 16/4/30.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

import UIKit

class FuncListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var baby = ["Swift与JS交互"]
    @IBOutlet weak var tableView :UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //每一块有多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baby.count
    }
    //绘制cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: initIdentifier)
        cell.textLabel?.text = baby[indexPath.row]
        cell.detailTextLabel?.text = "baby\(indexPath.row)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    //每个cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //隐藏bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

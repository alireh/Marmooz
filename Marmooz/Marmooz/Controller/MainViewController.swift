//
//  MainViewController.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var wordDatabase:WordDatabase!
    var info:Info!
    
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Assistant.isTestMode = false
        let loadingTime:TimeInterval = Assistant.isTestMode ? 0.1 : 2.0
        
        //
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //
        //
        //            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TestiStoryBoard") as! TestiViewController
        //            self.present(newViewController, animated: true, completion: nil)
        //        }
        //        return
        
        if(Assistant.isTestMode){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "StartStoryBoard") as! StartViewController
                self.present(newViewController, animated: true, completion: nil)
            }
        }
        else
        {
            let sourcePath1 = Bundle.main.path(forResource:"worddb", ofType: "db")
            wordDatabase = WordDatabase.getInstance(dbPAth: sourcePath1!)
            
            info = wordDatabase.getInfo(id:1)
            DispatchQueue.main.asyncAfter(deadline: .now() + loadingTime) {
                
                if(self.info.isInitialed == 0)
                {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "HelpStoryBoard") as! HelpPageViewController
                    self.present(newViewController, animated: true, completion: nil)
                    
                    self.info.isInitialed = 1
                    DatabaseInfo.info = self.info
                    self.wordDatabase.updateInfo(info:self.info)
                }
                else
                {
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "StartStoryBoard") as! StartViewController
                    self.present(newViewController, animated: true, completion: nil)
                }
            }
        }
        
        if(!Assistant.isTestMode){
            UIView.animate(withDuration: loadingTime, animations: { () -> Void in
                self.progressView.setProgress(1.0, animated: true)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


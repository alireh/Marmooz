//
//  StartViewController.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    
    var wordInfos:[WordInfo]! = []
    var wordDatabase:WordDatabase!
    var info:Info!
    
    @IBAction func Play_click(_ sender: Any) {
        
        let sourcePath = Bundle.main.path(forResource:"worddb", ofType: "db")
        wordDatabase = WordDatabase.getInstance(dbPAth: sourcePath!)
        
        DatabaseInfo.info = info;
        var wordInfos:[WordInfo]! = wordDatabase.getWordInfos()
        DatabaseInfo.wordInfosCount = wordInfos.count;
        
        var array:[Int] = [];
        var array1:[Int] = [];
        let shuffleGroupCount:Int = 4;
        let partCount:Int = wordInfos.count / shuffleGroupCount;
        
        if(wordInfos[0].orderIndex == nil){
            
            var index : Int = 1
            for k in 0...(shuffleGroupCount + 1) {
                if k >= shuffleGroupCount{
                    let max:Int = wordInfos.count % shuffleGroupCount
                    if(max == 0){
                        break
                    }
                    array = Assistant.createShuffledSequenceOfNumbers(max:max);
                }
                else{
                    array = Assistant.createShuffledSequenceOfNumbers(max:partCount);
                }
                
                
                for i in 0...(array.count - 1) {
                    
                    let wordIndex:Int = (k * partCount) + (i + 1);
                    if wordIndex <= wordInfos.count{
                        var wordInfo : WordInfo? = wordDatabase.getWordInfo(id:index)
                        index = index + 1
                        let orderIndex : Int! = array[i] + (k * partCount)
                        
                        array1.append(orderIndex)
                        
                        wordInfo?.orderIndex = orderIndex;
                        wordInfo?.xIndex = 0;
                        wordInfo?.yIndex = 0;
                        wordInfo?.isViewd = 0;
                        
                        wordDatabase.updateWordInfo(wordInfo:wordInfo);
                        wordInfos[i + (k * partCount)].orderIndex = (array[i] + (k * partCount));
                        wordInfos[i + (k * partCount)].xIndex = 0;
                        wordInfos[i + (k * partCount)].yIndex = 0;
                        wordInfos[i + (k * partCount)].isViewd = 0;
                    }
                }
            }
        }
        
        DatabaseInfo.wordInfos = wordInfos;
        performSegue(withIdentifier: "stageSegue", sender: self)
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sourcePath1 = Bundle.main.path(forResource:"worddb", ofType: "db")
        
        wordDatabase = WordDatabase.getInstance(dbPAth: sourcePath1!)
        var result = wordDatabase.getInfo(id:1)
        
        info = wordDatabase.getInfo(id:1)
        
        
        if(info.isSilent == 1)
        {
            if let image = UIImage(named: "speaker.png") {
                silentButton.setImage(image, for: .normal)
            }
        }
        else
        {
            if let image = UIImage(named: "silent.png") {
                silentButton.setImage(image, for: .normal)
            }
        }
        
        //let wordDatabase : WordDatabase!
        //let sourcePath = Bundle.main.path(forResource:"worddb", ofType: "db")
        
        //sqliteManager = SqliteManager.getInstance(dbPAth: "/worddb.db")
        //wordDatabase = WordDatabase.getInstance(dbPAth: sourcePath!)
        //wordDatabase.updateInfo(info: Info(infoId:1, score:950, pageStageCount:30, currentStage:1, latestStage:1))
        //        wordDatabase.updateWordInfo(wordInfo:WordInfo(wordInfoId:1,
        //        word:"اتریش",
        //        question:"a",
        //        isDisplayedMainCharacter:true,
        //        characterIndex:1,
        //        displayedIndexes:"1",
        //        orderIndex:1 ))
        
        //var result = wordDatabase.getInfo(id:1)
        //DatabaseInfo.wordInfosCount = wordDatabase.getWordInfosCount()
        //DatabaseInfo.info = result
        
        //var shuffleArray:[UInt] = Assistant.createShuffledSequenceOfNumbers(max:15)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func silentButton_Click(_ sender: Any) {
        
        if(silentButton.imageView?.image == UIImage(named:"silent.png"))
        {
            if let image = UIImage(named: "speaker.png") {
                silentButton.setImage(image, for: .normal)
                
                info?.isSilent = 1
                DatabaseInfo.info = info
                wordDatabase.updateInfo(info:info)
            }
        }
        else
        {
            if let image = UIImage(named: "silent.png") {
                silentButton.setImage(image, for: .normal)
                
                info?.isSilent = 0
                DatabaseInfo.info = info
                wordDatabase.updateInfo(info:info)
            }
        }
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    @IBOutlet weak var silentButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



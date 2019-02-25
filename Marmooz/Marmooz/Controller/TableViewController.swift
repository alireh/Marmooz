//
//  TableViewController.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    var info:Info!
    var wordInfo:WordInfo!
    var wordDatabase:WordDatabase!
    var wordArrangment:WordArrangment!
    var pairList:[Pair] = []
    var selectedButtonIdes:[Int]! = []
    var isSuccess:Bool = false
    let ROW:Int = 10
    let COLUMN:Int = 8
    let removeCharacterCount:Int = 5
    var wordNumberList:[Int] = []
    
    
    @IBOutlet weak var buttonsPanel: UIView!
    @IBOutlet weak var finishMsgLabel: UILabel!
    @IBOutlet weak var uiStack: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var targetCharLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var buttonsMainView: UIView!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var questionButton: UIButton!
    
    @IBOutlet weak var questionPopup: UIView!
    @IBOutlet weak var helpPopup: UIView!
    
    @IBOutlet weak var questionTextView: UITextView!
    //@IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        uiStack.heightAnchor.constraint(equalTo: uiStack.widthAnchor, multiplier: 1.0).isActive = true
        
        info = DatabaseInfo.info
        wordDatabase = WordDatabase.getInstance(dbPAth : "")
        info = DatabaseInfo.info
        
        wordArrangment = WordArrangment()
        GetIndexList(id:Assistant.currentId)
        
        
        let score:Int = info.score
        setScoreLabel(score:score)
        //changePoupEnability(score:score)
        changeHelpPoupButtonsEnability()
        
        scoreLabel.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        targetCharLabel.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        questionTextView.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        
        showMainLetterButton.titleLabel?.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        showOneLetterButton.titleLabel?.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        removeSomeLetterButton.titleLabel?.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:60))
        
        
        questionPopup.layer.cornerRadius = 10.0
        questionPopup.layer.shadowOpacity = 0.5
        questionPopup.layer.shadowRadius = 5
        
        helpPopup.layer.cornerRadius = 10.0
        helpPopup.layer.shadowOpacity = 0.5
        helpPopup.layer.shadowRadius = 5
        //        questionLabel.numberOfLines = 0
        //        questionLabel.contentMode = .scaleToFill
        
        
        
        //////////////////////////////////////////
        //        if DatabaseInfo.wordInfosCount > Assistant.currentId{
        //
        //            nextButton.isHidden = true
        //        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.displayButtons()
        }
        
        //displayButtons()
        setNavigationButtonsVisibility()
    }
    
    func displayButtons()
    {
        selectedButtonIdes = []
        isSuccess = false
        
        var buttonContentSequence:String = ""
        allButtons = []
        var i:Int = 0
        for innerView in uiStack.subviews
        {
            if let innerStack = innerView as? UIStackView
            {
                var j:Int = 0
                for innerStackElement in innerStack.subviews
                {
                    if let letterButton = innerStackElement as? UIButton
                    {
                        
                        let image = UIImage(named: "normalCircle") as UIImage?
                        letterButton.backgroundColor = .white
                        letterButton.setBackgroundImage(image, for: .normal)
                        letterButton.addTarget(self, action: #selector(letterButtonAction), for: .touchUpInside)
                        letterButton.setTitleColor(UIColor(red: 21.0, green: 126.0, blue: 251.0, alpha: 1.0), for:.normal)
                        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:nil))
                        
                        if(wordInfo.isViewd == 0)
                        {
                            let character : String = Assistant.randomChar(length:1)
                            buttonContentSequence.append(character)
                            letterButton.setTitle(character , for: .normal)
                        }
                        else
                        {
                            let bid = (i * 8 + j)
                            let c:String = wordInfo.letters[bid..<(bid + 1)]
                            letterButton.setTitle((c == "x" ? " " : c) , for: .normal)
                            
                            if c == "x"{
                                let image = UIImage(named: "emptyCircle") as UIImage?
                                letterButton.setBackgroundImage(image, for: .normal)
                            }
                        }
                        
                        
                        letterButton.clipsToBounds = true
                        letterButton.tag = (i * COLUMN + j + 1)
                        allButtons.append(letterButton)
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            UIView.animate(withDuration: 0.6,
                                           animations: {
                                            letterButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                            },
                                           completion: { _ in
                                            UIView.animate(withDuration: 0.6) {
                                                letterButton.transform = CGAffineTransform.identity
                                            }
                            })
                        }
                    }
                    j = j + 1
                }
                i = i + 1
            }
        }
        if(wordInfo.isViewd == 0){
            wordInfo.letters = buttonContentSequence
            wordInfo.isViewd = 1
            wordDatabase.updateWordInfo(wordInfo:wordInfo)
        }
        
        injectTargetWordToTable()
        
        if(Assistant.currentId < info.latestStage){
            selectInjectedButtons()
        }
        else{
            if(wordInfo.orderIndex < 4){
                let selectedLetterIndex:Int = selectOneLetter(isTargetIndex: true, index: -1)
                
                wordInfo.isDisplayedMainCharacter = true
                wordDatabase.updateWordInfo(wordInfo: wordInfo)
                var dispIndexes:String = wordInfo.displayedIndexes
                let selectedLetterIndex_str:String = String(selectedLetterIndex)
                
                if(dispIndexes == nil){
                    dispIndexes = ""
                }
                
                if(!dispIndexes.starts(with: selectedLetterIndex_str + ",") && !dispIndexes.contains("," + selectedLetterIndex_str + ",")){
                    let newDisplayIndexes:String = (dispIndexes == nil ? "" : dispIndexes) + selectedLetterIndex_str + ","
                    wordInfo.displayedIndexes = newDisplayIndexes
                    wordDatabase.updateWordInfo(wordInfo: wordInfo)
                }
            }
        }
        
        let displayedIndexes:String = wordInfo.displayedIndexes;
        if(displayedIndexes != "" && displayedIndexes != nil){
            var array = displayedIndexes.components(separatedBy: ",")
            for k in 0...(array.count - 1)
            {
                let s:String = array[k]
                if(s != "")
                {
                    do {
                        let s1: Int? = Int(s)
                        selectOneLetter(isTargetIndex: s1 == wordInfo.characterIndex - 1, index: s1!)
                    }
                    catch {
                        print("Not me error")
                    }
                }
            }
        }
        if(wordInfo.isDisplayedMainCharacter){
            selectOneLetter(isTargetIndex:true, index:-1);
        }
        
        if(Assistant.currentId == info.latestStage && Assistant.currentId < DatabaseInfo.wordInfosCount){
            displayQuestion(text: wordInfo.question)
        }
        
        let uiStackWidth:CGFloat = uiStack.frame.size.width
        let uiStackHeight:CGFloat = uiStack.frame.size.height
        
        if((uiStackHeight / uiStackWidth) < 10.0 / 8.0)
        {
            let ratio : Float = Float (COLUMN) / Float (ROW)
            uiStack.translatesAutoresizingMaskIntoConstraints = false
            uiStack.heightAnchor.constraint(equalTo: buttonsMainView.heightAnchor, multiplier: 0.96).isActive = true
            uiStack.widthAnchor.constraint(equalTo: uiStack.heightAnchor, multiplier: CGFloat(ratio)).isActive = true
            buttonsPanel.widthAnchor.constraint(equalTo: buttonsPanel.heightAnchor, multiplier: CGFloat(ratio)).isActive = true
        }
        else
        {
            let ratio : Float = Float (ROW) / Float (COLUMN)
            uiStack.translatesAutoresizingMaskIntoConstraints = false
            uiStack.widthAnchor.constraint(equalTo: buttonsMainView.widthAnchor, multiplier: 0.96).isActive = true
            uiStack.heightAnchor.constraint(equalTo: uiStack.widthAnchor, multiplier: CGFloat(ratio)).isActive = true
            buttonsPanel.heightAnchor.constraint(equalTo: buttonsPanel.widthAnchor, multiplier: CGFloat(ratio)).isActive = true
        }
        if IsValidSelection(){
            nextButton.isHidden = false
        }
        
        /////////////////////
        //nextButton.isHidden = false
    }
    
    
    func IsValidSelection() -> Bool
    {
        /////////////////////
        //return true
        
        var list:[Int] = []
        for k in 0...(pairList.count - 1)
        {
            let p:Pair = pairList[k]
            let index:Int = (p.x * 8 + p.y) + 1
            list.append(index)
        }
        
        if(list.count != selectedButtonIdes.count)
        {
            return false
        }
        for k in 0...(pairList.count - 1)
        {
            let p:Pair = pairList[k]
            let index:Int = (p.x * 8 + p.y) + 1
            if(!selectedButtonIdes.contains(index)){
                return false
            }
        }
        
        return true
    }
    
    func setScoreLabel(score:Int){
        scoreLabel.text = "امتیاز : " + String(score)
    }
    
    func GetIndexList(id:Int!){
        let wordInfos:[WordInfo] = DatabaseInfo.wordInfos
        
        for item in wordInfos {
            if(item.orderIndex == id)
            {
                wordInfo = item
                break
            }
        }
        wordInfo = wordDatabase.getWordInfo(id: wordInfo.wordInfoId)
        
        let characterIndex:Int = wordInfo.characterIndex
        
        var word = wordInfo.word
        word = word?.replacingOccurrences(of: " ", with: "")
        word = word?.replacingOccurrences(of: "آ", with: "ا")
        let firstChar = word![(characterIndex - 1)..<characterIndex]
        
        
        
        setTargetIndexLabel(digit:characterIndex)
        let pair:Pair = wordArrangment.MaxCharIndexDictionary[Character(firstChar)]!
        let max_x = pair.x
        let max_y = pair.y
        
        let x_index = (wordInfo.isViewd == 0) ? arc4random_uniform(UInt32(ROW) - UInt32(max_x)) : UInt32(wordInfo.xIndex)
        let y_index = (wordInfo.isViewd == 0) ? arc4random_uniform(UInt32(COLUMN) - UInt32(max_y))  : UInt32(wordInfo.yIndex)
        
        
        var pList:[Pair] = wordArrangment.IndexDictionary[Character(firstChar)]!
        
        pairList = []
        
        wordNumberList = []
        for i in 0...(pList.count - 1){
            let p:Pair = pList[i]
            let createdXIndex:Int = p.x + Int(x_index)
            let createdYIndex:Int = p.y + Int(y_index)
            pairList.append(Pair(x:createdXIndex, y:createdYIndex))
            
            
            let buttonNumber:Int = (createdXIndex * COLUMN + createdYIndex + 1)
            wordNumberList.append(buttonNumber)
        }
        
        
        wordInfo.xIndex = Int(x_index)
        wordInfo.yIndex = Int(y_index)
        //wordInfo.isViewd = 1
        //DatabaseInfo.wordInfo = self.wordInfo
        self.wordDatabase.updateWordInfo(wordInfo: self.wordInfo)
    }
    
    func setTargetIndexLabel(digit:Int){
        targetCharLabel.text = Assistant.getIndexText(digit:digit)
    }
    
    
    func displayQuestion(text:String){
        //questionLabel.text = text
        questionTextView.text = text
        questionPopup.isHidden = !questionPopup.isHidden
        helpPopup.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.questionPopup.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != questionPopup {
            questionPopup.isHidden = true
        }
        if touch?.view != helpPopup {
            helpPopup.isHidden = true
        }
    }
    
    @IBOutlet weak var showMainLetterButton: UIButton!
    @IBOutlet weak var showOneLetterButton: UIButton!
    @IBOutlet weak var removeSomeLetterButton: UIButton!
    
    @IBAction func removeSomeLetterButtonClick(_ sender: Any) {
        
        let score:Int = info.score
        if(score >= 30)
        {
            let newScore:Int = score - 30
            info.score = newScore
            wordDatabase.updateInfo(info:info)
            
            removeSomeCharacters()
            
            setScoreLabel(score:newScore)
            changeHelpPoupButtonsEnability()
            Assistant.playAudioFile(soundName: "tap2", format: "wav")
        }
    }
    
    @IBAction func showMainLetterButtonClick(_ sender: Any) {
        let score:Int = info.score
        if(score >= 120 && !wordInfo.isDisplayedMainCharacter){
            let newScore:Int = score - 120
            info.score = newScore
            wordDatabase.updateInfo(info:info)
            let selectedLetterIndex:Int = selectOneLetter(isTargetIndex: true, index: -1)
            setScoreLabel(score:newScore)
            
            wordInfo.isDisplayedMainCharacter = true
            wordDatabase.updateWordInfo(wordInfo:wordInfo)
            let dispIndexes:String = wordInfo.displayedIndexes ?? ""
            let selectedLetterIndex_str:String = String(selectedLetterIndex)
            
            if(!dispIndexes.starts(with: selectedLetterIndex_str + ",") && !dispIndexes.contains("," + selectedLetterIndex_str + ","))
            {
                let newDisplayIndexes:String = (dispIndexes == nil ? "" : dispIndexes) + selectedLetterIndex_str + ","
                wordInfo.displayedIndexes = newDisplayIndexes
                wordDatabase.updateWordInfo(wordInfo: wordInfo)
            }
            changeHelpPoupButtonsEnability()
            if(IsValidSelection()){
                nextButton.isHidden = false
                
                if(!isSuccess){
                    Assistant.playAudioFile(soundName: "success", format : "wav")
                    isSuccess = true
                }
            }
        }
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    func changeHelpPoupButtonsEnability(){
        let score:Int = info.score
        let displayedIndexesLength:Int = wordInfo.displayedIndexes == nil ? 0 : wordInfo.displayedIndexes.count
        showOneLetterButton.isEnabled = score >= 80 && pairList.count != displayedIndexesLength / 2
        showMainLetterButton.isEnabled = score >= 120 && !wordInfo.isDisplayedMainCharacter && pairList.count != displayedIndexesLength / 2 && wordInfo.orderIndex > 3
        removeSomeLetterButton.isEnabled = score >= 30 && pairList.count != displayedIndexesLength / 2 && isPossibleRemoveCharacters()
    }
    
    
    func isPossibleRemoveCharacters() -> Bool
    {
        let w:String = wordInfo.word
        let letters:String = wordInfo.letters
        if(letters == nil || letters == ""){
            return true
        }
        let removedSpaceWord:String = letters.replacingOccurrences(of: "x", with: "")
        if(removedSpaceWord.count >= (5 + w.count)){
            return true
        }
        return false
    }
    
    @IBAction func showOneLetterButtonClick(_ sender: Any) {
        let score:Int = info.score
        if(score >= 80){
            let newScore:Int = score - 80
            info.score = newScore
            wordDatabase.updateInfo(info:info)
            let selectedLetterIndex:Int = selectOneLetter(isTargetIndex:false, index:-1)
            setScoreLabel(score:newScore)
            
            let dispIndexes:String = wordInfo.displayedIndexes ?? ""
            let newDisplayIndexes:String = (dispIndexes == nil ? "" : dispIndexes) + String(selectedLetterIndex) + ","
            wordInfo.displayedIndexes = newDisplayIndexes
            wordDatabase.updateWordInfo(wordInfo: wordInfo)
            changeHelpPoupButtonsEnability()
            if(IsValidSelection()){
                nextButton.isHidden = false
                
                if(!isSuccess){
                    Assistant.playAudioFile(soundName: "success", format : "wav")
                    isSuccess = true
                }
            }
        }
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    @IBAction func Question_Click(_ sender: Any) {
        displayQuestion(text:wordInfo.question)
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    @IBAction func Help_Click(_ sender: Any) {
        helpPopup.isHidden = !helpPopup.isHidden
        questionPopup.isHidden = true
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    @IBAction func back_click(_ sender: Any) {
        if(Assistant.currentId > 1){
            Assistant.currentId = Assistant.currentId - 1
            GetIndexList(id:Assistant.currentId)
            displayButtons()
            //let score:Int = info.score
            changeHelpPoupButtonsEnability()
            DatabaseInfo.currentPage = Assistant.currentId
        }
        //changeHelpIconVisibility()
        setNavigationButtonsVisibility()
        questionPopup.isHidden = true
        helpPopup.isHidden = true
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    @IBAction func next_Click(_ sender: Any) {
        
        ///////////////////////////////////////////////
        //        Assistant.currentId = Assistant.currentId + 1
        //        info.currentStage = Assistant.currentId
        //        info.latestStage = Assistant.currentId
        //        info.score = info.score + 50
        //        DatabaseInfo.currentPage = Assistant.currentId
        //        GetIndexList(id: Assistant.currentId)
        //        displayButtons()
        //
        //        DatabaseInfo.info = info
        //        wordDatabase.updateInfo(info:info)
        //        setScoreLabel(score: info.score)
        //        setNavigationButtonsVisibility()
        //        return
        
        
        questionPopup.isHidden = true
        helpPopup.isHidden = true
        if(Assistant.currentId < info.latestStage){
            Assistant.currentId = Assistant.currentId + 1
            GetIndexList(id:Assistant.currentId)
            displayButtons()
        }
        else if(IsValidSelection()){
            Assistant.currentId = Assistant.currentId + 1
            info.currentStage = Assistant.currentId
            info.latestStage = Assistant.currentId
            info.score = info.score + 50
            GetIndexList(id: Assistant.currentId)
            displayButtons()
            
            DatabaseInfo.info = info
            wordDatabase.updateInfo(info:info)
            setScoreLabel(score: info.score)
            DatabaseInfo.currentPage = Assistant.currentId
        }
        //changeHelpIconVisibility()
        //changePoupEnability(score:info.score)
        changeHelpPoupButtonsEnability()
        setNavigationButtonsVisibility()
        
        ///////////////////////////
        
        //nextButton.isHidden = false
        
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToStageClick(_ sender: Any) {
        performSegue(withIdentifier: "backToStageSegue", sender: self)
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    
    var a:Int = 0
    var aw:Int = 0
    func removeSomeCharacters(){
        var removedCount:Int = 0
        let charCount:Int = ROW * COLUMN
        var letters:String = wordInfo.letters
        aw = aw + 1
        
        while(removedCount != removeCharacterCount)
        {
            let r:Int = Int(arc4random_uniform(UInt32(charCount)))
            
            if(!wordNumberList.contains(r + 1) && letters[(r)..<(r + 1)] != "x")
            {
                removedCount = removedCount + 1
                
                let targetBtn:UIButton = getButtonById(id: (r + 1))!
                targetBtn.setTitle(" ", for: .normal)
                
                targetBtn.backgroundColor = UIColor(red: 236.0, green: 236.0, blue: 236.0, alpha: 0.9)
                
                let image = UIImage(named: "emptyCircle") as UIImage?
                targetBtn.setBackgroundImage(image, for: .normal)
                
                letters = letters[0..<r] + "x" + letters[(r + 1)..<(letters.count)]
            }
        }
        wordInfo.letters = letters
        wordDatabase.updateWordInfo(wordInfo:wordInfo)
    }
    
    var allButtons : [UIButton]!
    //    func displayButtons1(){
    //        for subView in self.buttonsMainView.subviews {
    //            subView.removeFromSuperview()
    //        }
    //        var views : [UIView]! = []
    //        allButtons = []
    //        selectedButtonIdes = []
    //        isSuccess = false
    //
    //        for index in 0...(ROW - 1) {
    //            let v = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 180))
    //            views.append(v)
    //
    //            views[index].translatesAutoresizingMaskIntoConstraints = false
    //            self.buttonsMainView.addSubview(views[index])
    //
    //            views[index].widthAnchor.constraint(equalTo: self.buttonsMainView.widthAnchor, multiplier: 1.0).isActive = true
    //            //vs[index].heightAnchor.constraint(equalTo: self.buttonsMainView.heightAnchor, multiplier: 1/ROW).isActive = true
    //            self.buttonsMainView.trailingAnchor.constraint(equalTo: views[index].trailingAnchor, constant:0.0).isActive = true
    //            views[index].leadingAnchor.constraint(equalTo: self.buttonsMainView.leadingAnchor, constant:0.0).isActive = true
    //
    //
    //            if(index > 0)
    //            {
    //                views[index].topAnchor.constraint(equalTo: views[index - 1].bottomAnchor, constant:0.0).isActive = true
    //            }
    //            else
    //            {
    //                views[index].topAnchor.constraint(equalTo: self.buttonsMainView.topAnchor, constant:0.0).isActive = true
    //            }
    //        }
    //
    //        var buttonContentSequence:String = ""
    //        for i in 0...(ROW - 1)
    //        {
    //            var rowViews : [UIView]! = []
    //            var buttons : [UIButton]! = []
    //            for j in 0...(COLUMN - 1)
    //            {
    //                let b = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
    //                rowViews.append(b)
    //
    //                let letterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    //                if(wordInfo.isViewd == 0){
    //                    let character : String = Assistant.randomChar(length:1)
    //                    buttonContentSequence.append(character)
    //                    letterButton.setTitle(character , for: .normal)
    //                }
    //                else{
    //                    let bid = (i * 8 + j)
    //
    //                        letterButton.setTitle(wordInfo.letters[(bid)..<bid+1] , for: .normal)
    //
    //                }
    //                //letterButton.backgroundColor = UIColor.green
    //                let image = UIImage(named: "normalCircle") as UIImage?
    //                letterButton.setBackgroundImage(image, for: .normal)
    //                letterButton.setTitleColor(UIColor.black, for: UIControlState.normal)
    //                letterButton.addTarget(self, action: #selector(letterButtonAction), for: .touchUpInside)
    //                buttons.append(letterButton)
    //
    //                //b1.layer.cornerRadius = 20
    //                //letterButton.layer.cornerRadius = letterButton.bounds.size.height / 1.2
    //                letterButton.clipsToBounds = true
    //                letterButton.tag = (i * COLUMN + j + 1)
    //                allButtons.append(letterButton)
    //
    //                rowViews[j].translatesAutoresizingMaskIntoConstraints = false
    //                buttons[j].translatesAutoresizingMaskIntoConstraints = false
    //
    //                rowViews[j].addSubview(buttons[j])
    //
    //
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    //
    //                    UIView.animate(withDuration: 0.6,
    //                                   animations: {
    //                                    buttons[j].transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    //                    },
    //                                   completion: { _ in
    //                                    UIView.animate(withDuration: 0.6) {
    //                                        buttons[j].transform = CGAffineTransform.identity
    //                                    }
    //                    })
    //                }
    //
    //
    //
    //                let buttonThicknessPercentage : CGFloat = 0.8
    //                buttons[j].centerXAnchor.constraint(equalTo: rowViews[j].centerXAnchor).isActive = true
    //                buttons[j].centerYAnchor.constraint(equalTo: rowViews[j].centerYAnchor).isActive = true
    //                buttons[j].widthAnchor.constraint(equalTo: rowViews[j].widthAnchor, multiplier:buttonThicknessPercentage).isActive = true
    //                buttons[j].heightAnchor.constraint(equalTo: rowViews[j].heightAnchor, multiplier:buttonThicknessPercentage).isActive = true
    //                //buttons[j].addTarget(self, action: #selector(characterButtonAction), for: .touchUpInside)
    //
    //                views[i].addSubview(rowViews[j])
    //
    //                rowViews[j].widthAnchor.constraint(equalTo: views[i].widthAnchor, multiplier: 1/8).isActive = true
    //                rowViews[j].heightAnchor.constraint(equalTo: views[i].heightAnchor, multiplier: 1.0).isActive = true
    //                rowViews[j].bottomAnchor.constraint(equalTo: views[i].bottomAnchor, constant:0.0).isActive = true
    //                rowViews[j].topAnchor.constraint(equalTo: views[i].topAnchor, constant:0.0).isActive = true
    //
    //
    //                if(j > 0)
    //                {
    //                    rowViews[j].leftAnchor.constraint(equalTo: rowViews[j - 1].rightAnchor, constant:0.0).isActive = true
    //                }
    //                else
    //                {
    //                    rowViews[j].leftAnchor.constraint(equalTo: views[i].leftAnchor, constant:0.0).isActive = true
    //                }
    //            }
    //            views[i].heightAnchor.constraint(equalTo: rowViews[0].widthAnchor, multiplier: 1.0).isActive = true
    //        }
    //        if(wordInfo.isViewd == 0){
    //            wordInfo.letters = buttonContentSequence
    //            wordInfo.isViewd = 1
    //            wordDatabase.updateWordInfo(wordInfo:wordInfo)
    //        }
    //
    //        injectTargetWordToTable()
    //
    //        if(Assistant.currentId < info.latestStage){
    //            selectInjectedButtons()
    //        }
    //
    //        if(Assistant.currentId == info.latestStage){
    //            displayQuestion(text: wordInfo.question)
    //        }
    //    }
    
    func selectDisplayedIndexes(){
        let displayedIndexes:String = wordInfo.displayedIndexes
        if(displayedIndexes != "" && displayedIndexes != nil){
            let array:[String] = displayedIndexes.components(separatedBy: ",")
            for k in 0...(array.count - 1){
                let s:String = array[k]
                if(s != "")
                {
                    selectOneLetter(isTargetIndex:false, index:Int(s)!)
                }
            }
        }
    }
    
    func selectOneLetter(isTargetIndex:Bool, index:Int) -> Int{
        let r:Int = index != -1 ? index : (isTargetIndex ? (wordInfo.characterIndex - 1) : getRandomNumber())
        
        let p:Pair = pairList[r]
        let chosenID:Int = (p.x * COLUMN + p.y) + 1
        let targetBtn:UIButton = getButtonById(id: chosenID)!
        
        let btnId:Int = targetBtn.tag
        if(!selectedButtonIdes.contains(btnId)){
            selectedButtonIdes.append(btnId)
        }
        
        let image1 = UIImage(named: "targetCircle") as UIImage?
        let image2 = UIImage(named: "selectedCircle") as UIImage?
        targetBtn.setBackgroundImage(isTargetIndex ? image1 : image2, for: .normal)
        targetBtn.setTitleColor(UIColor.white, for:.normal)
        
        return r
    }
    
    
    func getRandomNumber() -> Int{
        var r:Int = 0
        let displayedIndexes:String = wordInfo.displayedIndexes ?? ""
        if(displayedIndexes != "")
        {
            let array:[String] = displayedIndexes.components(separatedBy: ",")
            var finded:Bool = false
            while(!finded)
            {
                r = Int(arc4random_uniform(UInt32(pairList.count)))
                if(!array.contains(String(r)))
                {
                    finded = true
                }
            }
        }
        else
        {
            r = Int(arc4random_uniform(UInt32(pairList.count)))
        }
        return r
    }
    
    func injectTargetWordToTable()
    {
        var w:String = wordInfo.word
        w = w.replacingOccurrences(of: " ", with: "")
        w = w.replacingOccurrences(of: "آ", with: "ا")
        var i:Int = 0
        for k in 0...(pairList.count - 1)
        {
            let p:Pair = pairList[k]
            let chosenID:Int = (p.x * COLUMN) + p.y + 1
            let btn:UIButton? = getButtonById(id: chosenID)
            if(btn != nil)
            {
                let part:String = w[i..<i + 1]
                btn?.setTitle(part /*+ "*" */, for: .normal)
                /////////////////////////////////
                //                let image = UIImage(named: "selectedCircle") as UIImage?
                //                btn?.setBackgroundImage(image, for: .normal)
                i = i + 1
                
                
                //                var letters1:String = wordInfo.letters
                //                letters1 = letters1[0..<chosenID] + part + letters1[(chosenID + 1)..<(letters1.count)]
                //                wordInfo.letters = letters1
                //                wordDatabase.updateWordInfo(wordInfo:wordInfo)
            }
        }
    }
    
    func selectInjectedButtons(){
        for k in 0...(pairList.count - 1)
        {
            let p:Pair = pairList[k]
            let chosenID:Int = (p.x * COLUMN + p.y) + 1
            let targetBtn:UIButton! = getButtonById(id: chosenID)
            selectedButtonIdes.append(targetBtn.tag)
            
            //targetBtn.backgroundColor = UIColor(red: 0.0, green: 110.0, blue: 180.0, alpha: 0.8)
            let image = UIImage(named: "selectedCircle") as UIImage?
            targetBtn.setBackgroundImage(image, for: .normal)
            targetBtn.setTitleColor(UIColor.white, for:.normal)
            targetBtn.setTitleColor(UIColor(red: 21.0, green: 126.0, blue: 251.0, alpha: 1.0), for:.normal)
        }
        selectOneLetter(isTargetIndex:true, index:-1)
    }
    
    @objc func letterButtonAction(sender: UIButton)
    {
        if(Assistant.currentId != info.latestStage){
            /////////////
            return
        }
        let button = sender
        let buttonId = button.tag
        
        let bt = sender as UIButton
        if(bt.titleLabel!.text == " "){
            return
        }
        
        if(selectedButtonIdes.contains(buttonId))
        {
            if let index = selectedButtonIdes.index(of:buttonId) {
                selectedButtonIdes.remove(at: index)
                //button.backgroundColor = .green
                
                let image = UIImage(named: "normalCircle") as UIImage?
                button.setBackgroundImage(image, for: .normal)
                button.setTitleColor(UIColor.white, for:.normal)
            }
        }
        else
        {
            selectedButtonIdes.append(buttonId)
            
            let image = UIImage(named: "selectedCircle") as UIImage?
            button.setBackgroundImage(image, for: .normal)
            
            //button.backgroundColor = UIColor(red: 0.0, green: 110.0, blue: 180.0, alpha: 0.8)
            button.setTitleColor(UIColor.white, for:.normal)
        }
        var flag:Bool = false
        nextButton.isHidden = true
        if(IsValidSelection()){
            nextButton.isHidden = false
            
            if(!isSuccess && Assistant.currentId == info.latestStage){
                Assistant.playAudioFile(soundName: "success", format : "wav")
                isSuccess = true
                flag = true
            }
        }
        questionPopup.isHidden = true
        helpPopup.isHidden = true
        
        if(!flag){
            Assistant.playAudioFile(soundName: "tap", format : "wav")
        }
    }
    
    //    func changeHelpIconVisibility()
    //    {
    //        helpButton.isHidden = true
    //        if(Assistant.currentId == info.latestStage){
    //            helpButton.isHidden = false
    //        }
    //    }
    
    func getButtonById(id:Int) -> UIButton?{
        for item in allButtons{
            if(item.tag == id){
                return item
            }
        }
        return nil
    }
    
    func setNavigationButtonsVisibility()
    {
        nextButton.isHidden = false
        backButton.isHidden = false
        finishMsgLabel.isHidden = true
        buttonsPanel.isHidden = false
        questionButton.isHidden = false
        helpButton.isHidden = true
        
        if(Assistant.currentId == info.latestStage)
        {
            /////////////////////////////////
            nextButton.isHidden = true
        }
        if(Assistant.currentId == 1){
            backButton.isHidden = true
        }
        
        if(Assistant.currentId == info.latestStage && Assistant.currentId <= DatabaseInfo.wordInfosCount && !((DatabaseInfo.wordInfosCount + 1) == Assistant.currentId)){
            helpButton.isHidden = false
        }
        if (DatabaseInfo.wordInfosCount + 1) == Assistant.currentId
        {
            finishMsgLabel.isHidden = false
            buttonsPanel.isHidden = true
            nextButton.isHidden = true
            questionButton.isHidden = true
            helpButton.isHidden = true
        }
        if(IsValidSelection()){
            nextButton.isHidden = false
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}




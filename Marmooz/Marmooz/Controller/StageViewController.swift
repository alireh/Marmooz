//
//  StageViewController.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import UIKit

class StageViewController: UIViewController {
    
    @IBOutlet weak var buttonsMainView: UIView!
    @IBOutlet weak var backStageButtons: UIButton!
    @IBOutlet weak var nextstageButtons: UIButton!
    
    var pageStageCount : Int!;
    var latestStage : Int!;
    var lastStage : Int!;
    var firstStageNumber : Int = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        let info : Info = DatabaseInfo.info;
        pageStageCount = info.pageStageCount;
        latestStage = info.latestStage;
        lastStage = DatabaseInfo.wordInfosCount;
        Assistant.currentId = info.currentStage
        if(DatabaseInfo.currentPage == nil){
            DatabaseInfo.currentPage = info.currentStage;
        }
        
        
        displayButtons(page:DatabaseInfo.currentPage)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeclick(_ sender: Any) {
        performSegue(withIdentifier: "homeSegue", sender: self)
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayButtons(page:Int){
        
        for subView in self.buttonsMainView.subviews {
            subView.removeFromSuperview()
        }
        
        
        if(page % pageStageCount == 0)
        {
            firstStageNumber = (((page / pageStageCount) - 1) * pageStageCount) + 1;
        }
        else
        {
            firstStageNumber = ((page / pageStageCount) * pageStageCount) + 1;
        }
        
        
        var vs : [UIView]! = []
        
        for index in 0...5 {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            vs.append(v);
            
            vs[index].translatesAutoresizingMaskIntoConstraints = false
            self.buttonsMainView.addSubview(vs[index]);
            
            vs[index].widthAnchor.constraint(equalTo: self.buttonsMainView.widthAnchor, multiplier: 1.0).isActive = true
            //vs[index].heightAnchor.constraint(equalTo: self.buttonsMainView.heightAnchor, multiplier: 1/6).isActive = true
            self.buttonsMainView.trailingAnchor.constraint(equalTo: vs[index].trailingAnchor, constant:0.0).isActive = true
            vs[index].leadingAnchor.constraint(equalTo: self.buttonsMainView.leadingAnchor, constant:0.0).isActive = true
            
            
            if(index > 0)
            {
                vs[index].topAnchor.constraint(equalTo: vs[index - 1].bottomAnchor, constant:0.0).isActive = true
            }
            else
            {
                vs[index].topAnchor.constraint(equalTo: self.buttonsMainView.topAnchor, constant:0.0).isActive = true
            }
        }
        
        var lastRowIndex:Int = -1
        for i in 0...5{
            var buttons : [UIView]! = []
            var buttons1 : [UIButton]! = []
            for j in 0...4{
                let b = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
                buttons.append(b);
                
                let b1 = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
                let number : Int = ((i * 5) + (j + firstStageNumber))
                if(number > lastStage){
                    lastRowIndex = i
                    break;
                }
                let numberStr : String = String(number)
                let persianNumberStr : String = Assistant.toPersianString(s:numberStr)
                b1.setTitle(persianNumberStr , for: .normal)
                b1.addTarget(self, action: #selector(stageButtonAction), for: .touchUpInside)
                b1.tag = number
                b1.titleLabel?.font = UIFont.systemFont(ofSize: Assistant.getFontSize(num:nil))
                b1.backgroundColor = UIColor.lightGray
                if(number <= latestStage)
                {
                    b1.backgroundColor = UIColor(red: 73.0 / 255.0, green: 141.0 / 255.0, blue: 151.0 / 255.0, alpha: 0.75)
                }
                else
                {
                    b1.isEnabled = false;
                }
                if number == DatabaseInfo.currentPage && number <= latestStage
                {
                    //                    b1.layer.borderColor = UIColor.yellow.cgColor
                    //                    b1.layer.borderWidth = 2
                    b1.setTitleColor(UIColor(red: 255.0 / 255.0, green: 231.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0), for: .normal)
                }
                buttons1.append(b1)
                
                buttons[j].translatesAutoresizingMaskIntoConstraints = false
                buttons1[j].translatesAutoresizingMaskIntoConstraints = false
                
                buttons[j].addSubview(buttons1[j])
                
                
                
                let buttonThicknessPercentage : CGFloat = 0.9;
                buttons1[j].centerXAnchor.constraint(equalTo: buttons[j].centerXAnchor).isActive = true
                buttons1[j].centerYAnchor.constraint(equalTo: buttons[j].centerYAnchor).isActive = true
                buttons1[j].widthAnchor.constraint(equalTo: buttons[j].widthAnchor, multiplier:buttonThicknessPercentage).isActive = true
                buttons1[j].heightAnchor.constraint(equalTo: buttons[j].heightAnchor, multiplier:buttonThicknessPercentage).isActive = true
                
                vs[i].addSubview(buttons[j]);
                
                buttons[j].widthAnchor.constraint(equalTo: vs[i].widthAnchor, multiplier: 1/5).isActive = true
                buttons[j].heightAnchor.constraint(equalTo: buttons[j].widthAnchor, multiplier: 1.0).isActive = true
                buttons[j].bottomAnchor.constraint(equalTo: vs[i].bottomAnchor, constant:0.0).isActive = true
                buttons[j].topAnchor.constraint(equalTo: vs[i].topAnchor, constant:0.0).isActive = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    UIView.animate(withDuration: 0.6,
                                   animations: {
                                    buttons[j].transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                    },
                                   completion: { _ in
                                    UIView.animate(withDuration: 0.6) {
                                        buttons[j].transform = CGAffineTransform.identity
                                    }
                    })
                }
                
                
                if(j > 0)
                {
                    buttons[j].leftAnchor.constraint(equalTo: buttons[j - 1].rightAnchor, constant:0.0).isActive = true
                }
                else
                {
                    buttons[j].leftAnchor.constraint(equalTo: vs[i].leftAnchor, constant:0.0).isActive = true
                }
            }
            
            if(i < lastRowIndex)
            {
                vs[i].heightAnchor.constraint(equalTo: buttons[0].widthAnchor, multiplier: 1.0).isActive = true
            }
        }
        setStagesNavigationButtonsVisibility()
    }
    
    
    @objc func stageButtonAction(sender: UIButton!) {
        let button = sender as UIButton
        
        let stageNumber = button.tag
        Assistant.currentId = stageNumber
        DatabaseInfo.currentPage = stageNumber
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TableStoryBoard") as! TableViewController
        self.present(newViewController, animated: true, completion: nil)
        
        Assistant.playAudioFile(soundName: "click", format : "mp3")
    }
    
    
    func setStagesNavigationButtonsVisibility(){
        backStageButtons.isEnabled = true
        nextstageButtons.isEnabled = true
        
        let c : Int = firstStageNumber + pageStageCount;
        if(DatabaseInfo.currentPage == 1){
            backStageButtons.isEnabled = false
        }
        if(c > lastStage)
        {
            nextstageButtons.isEnabled = false
        }
    }
    
    @IBAction func BackStageClick(_ sender: Any) {
        
        let c : Int = firstStageNumber - pageStageCount;
        DatabaseInfo.currentPage = c;
        if(DatabaseInfo.currentPage > 0)
        {
            displayButtons(page:DatabaseInfo.currentPage);
        }
        setStagesNavigationButtonsVisibility()
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
    }
    
    @IBAction func nextStageClick(_ sender: Any) {
        
        let c : Int = firstStageNumber + pageStageCount;
        //if(c <= lastStage && lastStage <= c + pageStageCount)
        
        if(c <= lastStage)
        {
            DatabaseInfo.currentPage = c;
            displayButtons(page:DatabaseInfo.currentPage);
        }
        setStagesNavigationButtonsVisibility()
        Assistant.playAudioFile(soundName: "tap2", format: "wav")
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




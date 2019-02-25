//
//  Assistant.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

public class Assistant{
    
    static var currentId:Int!
    static var isTestMode:Bool!
    
    static func createShuffledSequenceOfNumbers(max:Int)->[Int] {
        
        let isShuffle:Bool = true
        var array:[Int]! = []
        var myArray:[Int]! = []
        for i in 1...max {
            myArray.append(i)
        }
        for i in 1...max {
            array.append(i)
        }
        var tempArray:[Int]! = []
        for index in 0...(myArray.count - 1) {
            
            var isNotFinded:Bool = true
            while(isNotFinded){
                
                let randomNumber = isShuffle ? arc4random_uniform(UInt32(myArray.count)) : UInt32(index)
                let randomIndex = Int(randomNumber)
                
                if(!tempArray.contains(randomIndex)){
                    tempArray.append(randomIndex)
                    
                    array[randomIndex] = myArray[index]
                    isNotFinded = false
                }
            }
        }
        
        return array
    }
    
    static func randomChar(length: Int) -> String {
        
        let letters : NSString = "ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی";
        //let letters : NSString = "123456789abcdefghijklmnopqrstuvw";
        
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    static func englishCharacterToPersian(character: String) -> String {
        switch character {
        case "1":
            return "ا"
        case "2":
            return "ب"
        case "3":
            return "پ"
        case "4":
            return "ت"
        case "5":
            return "ث"
        case "6":
            return "ج"
        case "7":
            return "چ"
        case "8":
            return "ح"
        case "9":
            return "خ"
        case "a":
            return "د"
        case "b":
            return "ذ"
        case "c":
            return "ر"
        case "d":
            return "ز"
        case "e":
            return "ژ"
        case "f":
            return "س"
        case "g":
            return "ش"
        case "h":
            return "ص"
        case "i":
            return "ض"
        case "j":
            return "ط"
        case "k":
            return "ظ"
        case "l":
            return "ع"
        case "m":
            return "غ"
        case "n":
            return "ف"
        case "o":
            return "ق"
        case "p":
            return "ک"
        case "q":
            return "گ"
        case "r":
            return "ل"
        case "s":
            return "م"
        case "t":
            return "ن"
        case "u":
            return "و"
        case "v":
            return "ه"
        case "w":
            return "ی"
        default:
            return " "
        }
    }
    
    static func persianCharacterToEnglish(character: String) -> String {
        switch character {
        case "ا":
            return "1"
        case "ب":
            return "2"
        case "پ":
            return "3"
        case "ت":
            return "4"
        case "ث":
            return "5"
        case "ج":
            return "6"
        case "چ":
            return "7"
        case "ح":
            return "8"
        case "خ":
            return "9"
        case "د":
            return "a"
        case "ذ":
            return "b"
        case "ر":
            return "c"
        case "ز":
            return "d"
        case "ژ":
            return "e"
        case "س":
            return "f"
        case "ش":
            return "g"
        case "ص":
            return "h"
        case "ض":
            return "i"
        case "ط":
            return "j"
        case "ظ":
            return "k"
        case "ع":
            return "l"
        case "غ":
            return "m"
        case "ف":
            return "n"
        case "ق":
            return "o"
        case "ک":
            return "p"
        case "گ":
            return "q"
        case "ل":
            return "r"
        case "م":
            return "s"
        case "ن":
            return "t"
        case "و":
            return "u"
        case "ه":
            return "v"
        case "ی":
            return "w"
        default:
            return " "
        }
    }
    
    
    static func getIndexText(digit:Int) -> String{
        switch (digit)
        {
        case 1:
            return "حرف شماره اول";
        case 2:
            return "حرف شماره دوم";
        case 3:
            return "حرف شماره سوم";
        case 4:
            return "حرف شماره چهارم";
        case 5:
            return "حرف شماره پنجم";
        case 6:
            return "حرف شماره ششم";
        case 7:
            return "حرف شماره هفتم";
        case 8:
            return "حرف شماره هشتم";
        case 9:
            return "حرف شماره نهم";
        case 10:
            return "حرف شماره دهم";
        case 11:
            return "حرف شماره یازدهم";
        case 12:
            return "حرف شماره دوازدهم";
        case 13:
            return "حرف شماره سیزدهم";
        case 14:
            return "حرف شماره جهاردهم";
        case 15:
            return "حرف شماره پانزدهم";
        case 16:
            return "حرف شماره شانزدهم";
        default:
            return ""
        }
    }
    
    
    //    static func playSound()
    //    {
    //        let url = Bundle.main.url(forResource: "tap2", withExtension: ".wav")
    //        do {
    //            if audioPlayer != nil {
    //                audioPlayer!.stop()
    //                audioPlayer = nil
    //            }
    //            if let soundURL = url {
    //                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategorySoloAmbient)
    //                try AVAudioSession.sharedInstance().setActive(true)
    //                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
    //            }
    //            guard let audioPlayer = audioPlayer else { return }
    //            audioPlayer.prepareToPlay()
    //            audioPlayer.play()
    //        }
    //        catch let error { print(error.localizedDescription) }
    //    }
    
    static var audioPlayer: AVAudioPlayer?
    static var objPlayer: AVAudioPlayer?
    static func playAudioFile(soundName:String, format:String) {
        
        if(DatabaseInfo.info.isSilent == 0) {
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: format) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategorySoloAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            
            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // For iOS versions < 11
            //            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let aPlayer = objPlayer else { return }
            aPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func getFontSize(num:CGFloat?) -> CGFloat
    {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let x:CGFloat = (pow(screenWidth, 2))
        let y:CGFloat = (pow(screenHeight, 2))
        let screenInches:CGFloat = sqrt(x + y)
        
        if(num == nil){
            return (screenInches) / 40.0;
        }
        return (screenInches) / num!;
    }
    
    static func replaceStringInIndex(label: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(label.characters)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    static var normalColor:UIColor = UIColor(red: 241.0, green: 241.0, blue: 241.0, alpha: 1.0)
    static var selectedColor:UIColor = UIColor(red: 20.0, green: 135.0, blue: 177.0, alpha: 1.0)
    static var targetColor:UIColor = UIColor(red: 165.0, green: 33.0, blue: 93.0, alpha: 1.0)
    
    static func toPersianString(s:String) -> String{
        var result : String! = s;
        result = result.replacingOccurrences(of: "1", with: "۱")
        result = result.replacingOccurrences(of: "2", with: "۲")
        result = result.replacingOccurrences(of: "3", with: "۳")
        result = result.replacingOccurrences(of: "4", with: "۴")
        result = result.replacingOccurrences(of: "5", with: "۵")
        result = result.replacingOccurrences(of: "6", with: "۶")
        result = result.replacingOccurrences(of: "7", with: "۷")
        result = result.replacingOccurrences(of: "8", with: "۸")
        result = result.replacingOccurrences(of: "9", with: "۹")
        result = result.replacingOccurrences(of: "0", with: "۰")
        
        return result;
    }
}


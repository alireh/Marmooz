//
//  WordDatabase.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import GRDB

public class WordDatabase{
    
    static var instance : WordDatabase!
    var databaseQueue : DatabaseQueue!
    
    // Word table name
    let TABLE_WORD:String = "word";
    // Info table name
    let TABLE_INFO:String = "info";
    
    
    // Info Table Columns names
    let KEY_INFOID:String = "infoId";
    let KEY_SCORE:String = "score";
    let KEY_PAGESTAGECOUNT:String = "pageStageCount";
    let KEY_CURRENTSTAGE:String = "currentPage";
    let KEY_LATESTSTAGE:String = "latestStage";
    let KEY_IS_SILENT:String = "isSilent";
    let KEY_IS_INITIALED:String = "isInitialed";
    
    // Word Table Columns names
    let KEY_WORDINFOID:String = "wordInfoId";
    let KEY_ORDER_ID:String = "orderId";
    let KEY_WORD:String = "word";
    let KEY_QUESTION:String = "question";
    let KEY_IS_DISPLAYED_MAIN_CHARACTER:String = "isDisplayedMainCharacter";
    let KEY_CHARACTERINDEX:String = "characterIndex";
    let KEY_DISPLAYEDINDEXES:String = "displayedIndexes";
    let KEY_ORDERINDEX:String = "orderIndex";
    let KEY_XINDEX:String = "xIndex";
    let KEY_YINDEX:String = "yIndex";
    let KEY_LETTERS:String = "letters";
    let KEY_ISVIEWD:String = "isViewd";
    
    init()
    {
    }
    
    init(dbPAth:String)
    {
        do {
            self.databaseQueue = try DatabaseQueue(path: dbPAth)
            
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    public static func getInstance(dbPAth:String) -> WordDatabase
    {
        if (instance == nil)
        {
            instance = WordDatabase(dbPAth:dbPAth)
        }
        return instance;
    }
    
    public func getWordInfos() -> [WordInfo]!
    {
        var result : [WordInfo]! = []
        do{
            let KEY_PARAMETERS : String = KEY_ORDER_ID + ", " + KEY_WORD + ", " + KEY_QUESTION + ", " + KEY_IS_DISPLAYED_MAIN_CHARACTER + ", " + KEY_CHARACTERINDEX + ", " + KEY_DISPLAYEDINDEXES + ", " + KEY_ORDERINDEX + ", " + KEY_XINDEX + ", " + KEY_YINDEX + ", " + KEY_LETTERS + ", " + KEY_ISVIEWD
            
            let query : String! = String(format: "SELECT %@ FROM %@ order by %@", KEY_PARAMETERS, TABLE_WORD, KEY_ORDER_ID);
            
            var rows: RowCursor!
            try databaseQueue.inDatabase { db in
                rows = try Row.fetchCursor(db, query)
                while let row = try rows.next() {
                    let wordInfoId1 : Int! = row[KEY_ORDER_ID]
                    let word1 : String! = row[KEY_WORD]
                    let question1 : String! = row[KEY_QUESTION]
                    let isDisplayedMainCharacter1: Bool! = row[KEY_IS_DISPLAYED_MAIN_CHARACTER]
                    let characterIndex1: Int! = row[KEY_CHARACTERINDEX]
                    let displayedIndexes1: String! = row[KEY_DISPLAYEDINDEXES]
                    let orderIndex1: Int! = row[KEY_ORDERINDEX]
                    let xIndex1: Int! = row[KEY_XINDEX]
                    let yIndex1: Int! = row[KEY_YINDEX]
                    let letters1: String! = row[KEY_LETTERS]
                    let isViewd1: Int! = row[KEY_ISVIEWD]
                    
                    
                    result.append(WordInfo(wordInfoId: wordInfoId1,
                                           word: word1,
                                           question: question1,
                                           isDisplayedMainCharacter:isDisplayedMainCharacter1,
                                           characterIndex:characterIndex1,
                                           displayedIndexes : displayedIndexes1,
                                           orderIndex:orderIndex1,
                                           xIndex:xIndex1,
                                           yIndex:yIndex1,
                                           letters:letters1,
                                           isViewd:isViewd1
                    ))
                }
            }
        }
        catch{
            print("Unexpected error: \(error).")
        }
        return result
    }
    
    
    
    public func getWordInfosCount() -> Int!
    {
        var count : Int!
        do{
            let query : String! = String(format: "SELECT COUNT(*) FROM %@", TABLE_WORD);
            
            try databaseQueue.inDatabase
            {
                db in count = try Int.fetchOne(db, query)!
            }
        }
        catch{
            print("Unexpected error: \(error).")
        }
        return count
    }
    
    
    public func getWordInfo(id:Int!) -> WordInfo?
    {
        var result : WordInfo?
        do{
            let KEY_PARAMETERS : String = KEY_ORDER_ID + ", " + KEY_WORD + ", " + KEY_QUESTION + ", " + KEY_IS_DISPLAYED_MAIN_CHARACTER + ", " + KEY_CHARACTERINDEX + ", " + KEY_DISPLAYEDINDEXES + ", " + KEY_ORDERINDEX + ", " + KEY_XINDEX + ", " + KEY_YINDEX + ", " + KEY_LETTERS + ", " + KEY_ISVIEWD
            
            let condition:String = KEY_ORDER_ID + " = " + String(id)
            let query : String! = String(format: "SELECT %@ FROM %@ WHERE %@", KEY_PARAMETERS, TABLE_WORD, condition);
            
            var rows: RowCursor!
            try databaseQueue.inDatabase { db in
                rows = try Row.fetchCursor(db, query)
                while let row = try rows.next() {
                    let wordInfoId1 : Int! = row[KEY_ORDER_ID]
                    let word1 : String! = row[KEY_WORD]
                    let question1 : String! = row[KEY_QUESTION]
                    let isDisplayedMainCharacter1: Bool! = row[KEY_IS_DISPLAYED_MAIN_CHARACTER]
                    let characterIndex1: Int! = row[KEY_CHARACTERINDEX]
                    let displayedIndexes1: String! = row[KEY_DISPLAYEDINDEXES]
                    let orderIndex1: Int! = row[KEY_ORDERINDEX]
                    let xIndex1: Int! = row[KEY_XINDEX]
                    let yIndex1: Int! = row[KEY_YINDEX]
                    let letters1: String! = row[KEY_LETTERS]
                    let isViewd1: Int! = row[KEY_ISVIEWD]
                    
                    result = WordInfo(wordInfoId: wordInfoId1,
                                      word: word1,
                                      question: question1,
                                      isDisplayedMainCharacter:isDisplayedMainCharacter1,
                                      characterIndex:characterIndex1,
                                      displayedIndexes : displayedIndexes1,
                                      orderIndex:orderIndex1,
                                      xIndex:xIndex1,
                                      yIndex:yIndex1,
                                      letters:letters1,
                                      isViewd:isViewd1
                    )
                }
            }
        }
        catch{
            print("Unexpected error: \(error).")
        }
        return result
    }
    
    
    public func getInfo(id:Int!) -> Info?
    {
        var result : Info?
        do{
            let KEY_PARAMETERS : String = KEY_INFOID + ", " + KEY_SCORE + ", " + KEY_PAGESTAGECOUNT + ", " + KEY_CURRENTSTAGE + ", " + KEY_LATESTSTAGE + ", "  + KEY_IS_SILENT + ", "  + KEY_IS_INITIALED
            
            let condition:String = KEY_INFOID + " = " + String(id)
            let query : String! = String(format: "SELECT %@ FROM %@ WHERE %@", KEY_PARAMETERS, TABLE_INFO, condition);
            
            var rows: RowCursor!
            try databaseQueue.inDatabase { db in
                rows = try Row.fetchCursor(db, query)
                while let row = try rows.next() {
                    let infoId1 : Int! = row[KEY_INFOID]
                    let score1 : Int! = row[KEY_SCORE]
                    let pageStageCount1 : Int! = row[KEY_PAGESTAGECOUNT]
                    let currentStage1: Int! = row[KEY_CURRENTSTAGE]
                    let latestStage1: Int! = row[KEY_LATESTSTAGE]
                    let isSilent1: Int! = row[KEY_IS_SILENT]
                    let isInitialed1: Int! = row[KEY_IS_INITIALED]
                    
                    
                    result = Info(infoId: infoId1,
                                  score: score1,
                                  pageStageCount: pageStageCount1,
                                  currentStage:currentStage1,
                                  latestStage:latestStage1,
                                  isSilent:isSilent1,
                                  isInitialed:isInitialed1
                    )
                }
            }
        }
        catch{
            print("Unexpected error: \(error).")
        }
        return result
    }
    
    public func updateInfo(info:Info!) -> Int!
    {
        do{
            let KEY_PARAMETERS : String = String(format: "(%@, %@, %@, %@, %@, %@) = ('%@','%@','%@','%@','%@','%@')",
                                                 KEY_SCORE,
                                                 KEY_PAGESTAGECOUNT,
                                                 KEY_CURRENTSTAGE,
                                                 KEY_LATESTSTAGE,
                                                 KEY_IS_SILENT,
                                                 KEY_IS_INITIALED,
                                                 String(info.score),
                                                 String(info.pageStageCount),
                                                 String(info.currentStage),
                                                 String(info.latestStage),
                                                 String(info.isSilent),
                                                 String(info.isInitialed))
            
            let condition:String = KEY_INFOID + " = 1" //+ String(info.infoId)
            let query : String! = String(format: "UPDATE %@ SET %@ WHERE %@", TABLE_INFO, KEY_PARAMETERS, condition);
            
            try databaseQueue.inDatabase { db in
                try db.execute(query)
            }
        }
        catch{
            return -1
            //print("Unexpected error: \(error).")
        }
        return 1//info.infoId)
    }
    
    public func updateWordInfo(wordInfo:WordInfo!) -> Int!
    {
        do{
            let KEY_PARAMETERS : String = String(format: "(%@, %@, %@, %@, %@, %@, %@, %@, %@, %@) = ('%@','%@','%@','%@','%@','%@','%@','%@', '%@','%@')",
                                                 KEY_WORD,
                                                 KEY_QUESTION,
                                                 KEY_IS_DISPLAYED_MAIN_CHARACTER,
                                                 KEY_CHARACTERINDEX,
                                                 KEY_DISPLAYEDINDEXES,
                                                 KEY_ORDERINDEX,
                                                 KEY_XINDEX,
                                                 KEY_YINDEX,
                                                 KEY_LETTERS,
                                                 KEY_ISVIEWD,
                                                 String(wordInfo.word ?? ""),
                                                 String(wordInfo.question ?? ""),
                                                 String(wordInfo.isDisplayedMainCharacter),
                                                 String(wordInfo.characterIndex),
                                                 String(wordInfo.displayedIndexes ?? ""),
                                                 String(wordInfo.orderIndex),
                                                 String(wordInfo.xIndex ?? 0),
                                                 String(wordInfo.yIndex ?? 0),
                                                 String(wordInfo.letters ?? ""),
                                                 String(wordInfo.isViewd ?? 0))
            
            let condition:String = KEY_ORDER_ID + " = " + String(wordInfo.wordInfoId)
            let query : String! = String(format: "UPDATE %@ SET %@ WHERE %@", TABLE_WORD, KEY_PARAMETERS, condition);
            
            try databaseQueue.inDatabase { db in
                try db.execute(query)
            }
        }
        catch{
            //return -1
            print("Unexpected error: \(error).")
        }
        return Int(wordInfo.wordInfoId)
    }
}



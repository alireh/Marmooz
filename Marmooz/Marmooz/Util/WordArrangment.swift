//
//  WordArrangment.swift
//  Marmooz
//
//  Created by Macbook on 8/2/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation


public class WordArrangment {
    var IndexDictionary : [Character: [Pair]]
    var MaxCharIndexDictionary : [Character: Pair]
    
    init(){
        IndexDictionary = [:]
        MaxCharIndexDictionary = [:]
        fillIndexList()
    }
    
    func fillIndexList(){
        
        //۵ * ۱
        //۵
        var list_a:[Pair] = []
        list_a.append(Pair(x:0, y:0))
        list_a.append(Pair(x:1, y:0))
        list_a.append(Pair(x:2, y:0))
        list_a.append(Pair(x:3, y:0))
        list_a.append(Pair(x:4, y:0))
        IndexDictionary["ا"] = list_a
        MaxCharIndexDictionary["ا"] = Pair(x:4, y:0);
        
        
        
        //۳ * ۵
        //۸
        var list_b:[Pair] = []
        list_b.append(Pair(x:0, y:4))
        list_b.append(Pair(x:1, y:4))
        list_b.append(Pair(x:1, y:3))
        list_b.append(Pair(x:1, y:2))
        list_b.append(Pair(x:1, y:1))
        list_b.append(Pair(x:1, y:0))
        list_b.append(Pair(x:0, y:0))
        list_b.append(Pair(x:2, y:2))
        IndexDictionary["ب"] = list_b
        MaxCharIndexDictionary["ب"] = Pair(x:2, y:4);
        
        
        //۳ * ۵
        //۱۰
        var list_p:[Pair] = []
        list_p.append(Pair(x:0, y:4))
        list_p.append(Pair(x:1, y:4))
        list_p.append(Pair(x:1, y:3))
        list_p.append(Pair(x:1, y:2))
        list_p.append(Pair(x:1, y:1))
        list_p.append(Pair(x:1, y:0))
        list_p.append(Pair(x:0, y:0))
        list_p.append(Pair(x:2, y:3))
        list_p.append(Pair(x:2, y:2))
        list_p.append(Pair(x:2, y:1))
        IndexDictionary["پ"] = list_p
        MaxCharIndexDictionary["پ"] = Pair(x:2, y:5);
        
        
        //۲ * ۶
        //۱۰
        var list_t:[Pair] = []
        list_t.append(Pair(x:0, y:3))
        list_t.append(Pair(x:0, y:2))
        list_t.append(Pair(x:1, y:5))
        list_t.append(Pair(x:2, y:5))
        list_t.append(Pair(x:2, y:4))
        list_t.append(Pair(x:2, y:3))
        list_t.append(Pair(x:2, y:2))
        list_t.append(Pair(x:2, y:1))
        list_t.append(Pair(x:2, y:0))
        list_t.append(Pair(x:1, y:0))
        IndexDictionary["ت"] = list_t
        MaxCharIndexDictionary["ت"] = Pair(x:2, y:5);
        
        
        
        //۷ * ۴
        //۱۱
        var list_h:[Pair] = []
        list_h.append(Pair(x:0, y:1))
        list_h.append(Pair(x:0, y:2))
        list_h.append(Pair(x:1, y:3))
        list_h.append(Pair(x:2, y:2))
        list_h.append(Pair(x:2, y:1))
        list_h.append(Pair(x:3, y:0))
        list_h.append(Pair(x:4, y:0))
        list_h.append(Pair(x:5, y:0))
        list_h.append(Pair(x:6, y:1))
        list_h.append(Pair(x:6, y:2))
        list_h.append(Pair(x:6, y:3))
        IndexDictionary["ح"] = list_h
        MaxCharIndexDictionary["ح"] = Pair(x:6, y:3);
        
        
        
        //۷ * ۴
        //۱۲
        var list_j:[Pair] = []
        list_j.append(Pair(x:0, y:1))
        list_j.append(Pair(x:0, y:2))
        list_j.append(Pair(x:1, y:3))
        list_j.append(Pair(x:2, y:2))
        list_j.append(Pair(x:2, y:1))
        list_j.append(Pair(x:3, y:0))
        list_j.append(Pair(x:4, y:0))
        list_j.append(Pair(x:5, y:0))
        list_j.append(Pair(x:6, y:1))
        list_j.append(Pair(x:6, y:2))
        list_j.append(Pair(x:6, y:3))
        list_j.append(Pair(x:4, y:2))
        IndexDictionary["ج"] = list_j
        MaxCharIndexDictionary["ج"] = Pair(x:6, y:3);
        
        
        
        
        //۹ * ۴
        //۱۲
        var list_kh:[Pair] = []
        list_kh.append(Pair(x:0, y:1))
        list_kh.append(Pair(x:2, y:1))
        list_kh.append(Pair(x:2, y:2))
        list_kh.append(Pair(x:3, y:3))
        list_kh.append(Pair(x:4, y:2))
        list_kh.append(Pair(x:4, y:1))
        list_kh.append(Pair(x:5, y:0))
        list_kh.append(Pair(x:6, y:0))
        list_kh.append(Pair(x:7, y:0))
        list_kh.append(Pair(x:8, y:1))
        list_kh.append(Pair(x:8, y:2))
        list_kh.append(Pair(x:8, y:3))
        IndexDictionary["خ"] = list_kh
        MaxCharIndexDictionary["خ"] = Pair(x:8, y:3);
        
        
        //۵ * ۳
        //۵
        var list_dal:[Pair] = []
        list_dal.append(Pair(x:0, y:0))
        list_dal.append(Pair(x:1, y:1))
        list_dal.append(Pair(x:2, y:2))
        list_dal.append(Pair(x:3, y:1))
        list_dal.append(Pair(x:4, y:0))
        IndexDictionary["د"] = list_dal
        MaxCharIndexDictionary["د"] = Pair(x:4, y:2);
        
        
        
        //۴ * ۴
        //۵
        var list_r:[Pair] = []
        list_r.append(Pair(x:0, y:3))
        list_r.append(Pair(x:1, y:3))
        list_r.append(Pair(x:2, y:2))
        list_r.append(Pair(x:3, y:1))
        list_r.append(Pair(x:3, y:0))
        IndexDictionary["ر"] = list_r
        MaxCharIndexDictionary["ر"] = Pair(x:3, y:3);
        
        
        //۶ * ۴
        //۶
        var list_z:[Pair] = []
        list_z.append(Pair(x:0, y:3))
        list_z.append(Pair(x:2, y:3))
        list_z.append(Pair(x:3, y:3))
        list_z.append(Pair(x:4, y:2))
        list_z.append(Pair(x:5, y:1))
        list_z.append(Pair(x:5, y:0))
        IndexDictionary["ز"] = list_z
        MaxCharIndexDictionary["ز"] = Pair(x:5, y:3);
        
        
        //۴ * ۸
        //۱۱
        var list_sin:[Pair] = []
        list_sin.append(Pair(x:0, y:7))
        list_sin.append(Pair(x:1, y:6))
        list_sin.append(Pair(x:0, y:5))
        list_sin.append(Pair(x:1, y:4))
        list_sin.append(Pair(x:0, y:3))
        list_sin.append(Pair(x:1, y:3))
        list_sin.append(Pair(x:2, y:3))
        list_sin.append(Pair(x:3, y:2))
        list_sin.append(Pair(x:3, y:1))
        list_sin.append(Pair(x:2, y:0))
        list_sin.append(Pair(x:1, y:0))
        IndexDictionary["س"] = list_sin
        MaxCharIndexDictionary["س"] = Pair(x:3, y:7);
        
        
        //۶ * ۸
        //۱۴
        var list_shin:[Pair] = []
        list_shin.append(Pair(x:0, y:6))
        list_shin.append(Pair(x:0, y:5))
        list_shin.append(Pair(x:0, y:4))
        list_shin.append(Pair(x:2, y:7))
        list_shin.append(Pair(x:3, y:6))
        list_shin.append(Pair(x:2, y:5))
        list_shin.append(Pair(x:3, y:4))
        list_shin.append(Pair(x:2, y:3))
        list_shin.append(Pair(x:3, y:3))
        list_shin.append(Pair(x:4, y:3))
        list_shin.append(Pair(x:5, y:2))
        list_shin.append(Pair(x:5, y:1))
        list_shin.append(Pair(x:4, y:0))
        list_shin.append(Pair(x:3, y:0))
        IndexDictionary["ش"] = list_shin
        MaxCharIndexDictionary["ش"] = Pair(x:5, y:7);
        
        
        //۶ * ۸
        //۱۴
        var list_sad:[Pair] = []
        list_sad.append(Pair(x:1, y:5))
        list_sad.append(Pair(x:0, y:6))
        list_sad.append(Pair(x:0, y:7))
        list_sad.append(Pair(x:1, y:7))
        list_sad.append(Pair(x:2, y:6))
        list_sad.append(Pair(x:2, y:5))
        list_sad.append(Pair(x:2, y:4))
        list_sad.append(Pair(x:2, y:3))
        list_sad.append(Pair(x:3, y:3))
        list_sad.append(Pair(x:4, y:3))
        list_sad.append(Pair(x:5, y:2))
        list_sad.append(Pair(x:5, y:1))
        list_sad.append(Pair(x:4, y:0))
        list_sad.append(Pair(x:3, y:0))
        IndexDictionary["ص"] = list_sad
        MaxCharIndexDictionary["ص"] = Pair(x:5, y:7);
        
        
        
        //۸ * ۸
        //۱۵
        var list_zad:[Pair] = []
        list_zad.append(Pair(x:0, y:6))
        list_zad.append(Pair(x:3, y:5))
        list_zad.append(Pair(x:2, y:6))
        list_zad.append(Pair(x:2, y:7))
        list_zad.append(Pair(x:3, y:7))
        list_zad.append(Pair(x:4, y:6))
        list_zad.append(Pair(x:4, y:5))
        list_zad.append(Pair(x:4, y:4))
        list_zad.append(Pair(x:4, y:3))
        list_zad.append(Pair(x:5, y:3))
        list_zad.append(Pair(x:6, y:3))
        list_zad.append(Pair(x:7, y:2))
        list_zad.append(Pair(x:7, y:1))
        list_zad.append(Pair(x:6, y:0))
        list_zad.append(Pair(x:5, y:0))
        IndexDictionary["ض"] = list_zad
        MaxCharIndexDictionary["ض"] = Pair(x:7, y:7);
        
        
        //۵ * ۴
        //۱۱
        var list_ta:[Pair] = []
        list_ta.append(Pair(x:3, y:1))
        list_ta.append(Pair(x:2, y:2))
        list_ta.append(Pair(x:2, y:3))
        list_ta.append(Pair(x:3, y:3))
        list_ta.append(Pair(x:4, y:2))
        list_ta.append(Pair(x:4, y:1))
        list_ta.append(Pair(x:4, y:0))
        list_ta.append(Pair(x:3, y:0))
        list_ta.append(Pair(x:2, y:0))
        list_ta.append(Pair(x:1, y:0))
        list_ta.append(Pair(x:0, y:0))
        IndexDictionary["ط"] = list_ta
        MaxCharIndexDictionary["ط"] = Pair(x:4, y:3);
        
        //۵ * ۴
        //۱۲
        var list_za:[Pair] = []
        list_za.append(Pair(x:0, y:2))
        list_za.append(Pair(x:3, y:1))
        list_za.append(Pair(x:2, y:2))
        list_za.append(Pair(x:2, y:3))
        list_za.append(Pair(x:3, y:3))
        list_za.append(Pair(x:4, y:2))
        list_za.append(Pair(x:4, y:1))
        list_za.append(Pair(x:4, y:0))
        list_za.append(Pair(x:3, y:0))
        list_za.append(Pair(x:2, y:0))
        list_za.append(Pair(x:1, y:0))
        list_za.append(Pair(x:0, y:0))
        IndexDictionary["ظ"] = list_za
        MaxCharIndexDictionary["ظ"] = Pair(x:4, y:3);
        
        
        //۷ * ۳
        //۸
        var list_eyn:[Pair] = []
        list_eyn.append(Pair(x:0, y:2))
        list_eyn.append(Pair(x:1, y:1))
        list_eyn.append(Pair(x:2, y:2))
        list_eyn.append(Pair(x:3, y:1))
        list_eyn.append(Pair(x:4, y:0))
        list_eyn.append(Pair(x:5, y:0))
        list_eyn.append(Pair(x:6, y:1))
        list_eyn.append(Pair(x:6, y:2))
        IndexDictionary["ع"] = list_eyn
        MaxCharIndexDictionary["ع"] = Pair(x:6, y:2);
        
        
        //۹ * ۳
        //۹
        var list_gheyn:[Pair] = []
        list_gheyn.append(Pair(x:0, y:2))
        list_gheyn.append(Pair(x:2, y:2))
        list_gheyn.append(Pair(x:3, y:1))
        list_gheyn.append(Pair(x:4, y:2))
        list_gheyn.append(Pair(x:5, y:1))
        list_gheyn.append(Pair(x:6, y:0))
        list_gheyn.append(Pair(x:7, y:0))
        list_gheyn.append(Pair(x:8, y:1))
        list_gheyn.append(Pair(x:8, y:2))
        IndexDictionary["غ"] = list_gheyn
        MaxCharIndexDictionary["غ"] = Pair(x:8, y:2);
        
        
        
        //۶ * ۵
        //۱۳
        var list_f:[Pair] = []
        list_f.append(Pair(x:0, y:4))
        list_f.append(Pair(x:2, y:4))
        list_f.append(Pair(x:2, y:3))
        list_f.append(Pair(x:3, y:4))
        list_f.append(Pair(x:3, y:3))
        list_f.append(Pair(x:4, y:4))
        list_f.append(Pair(x:5, y:4))
        list_f.append(Pair(x:5, y:3))
        list_f.append(Pair(x:5, y:2))
        list_f.append(Pair(x:5, y:1))
        list_f.append(Pair(x:5, y:0))
        list_f.append(Pair(x:4, y:0))
        list_f.append(Pair(x:3, y:0))
        IndexDictionary["ف"] = list_f
        MaxCharIndexDictionary["ف"] = Pair(x:5, y:4);
        
        
        
        
        //۶ * ۴
        //۱۱
        var list_gh:[Pair] = []
        list_gh.append(Pair(x:0, y:3))
        list_gh.append(Pair(x:0, y:2))
        list_gh.append(Pair(x:2, y:3))
        list_gh.append(Pair(x:2, y:2))
        list_gh.append(Pair(x:3, y:3))
        list_gh.append(Pair(x:3, y:2))
        list_gh.append(Pair(x:4, y:3))
        list_gh.append(Pair(x:5, y:2))
        list_gh.append(Pair(x:5, y:1))
        list_gh.append(Pair(x:4, y:0))
        list_gh.append(Pair(x:3, y:0))
        IndexDictionary["ق"] = list_gh
        MaxCharIndexDictionary["ق"] = Pair(x:5, y:3);
        
        
        
        //۴ * ۶
        //۱۱
        var list_k:[Pair] = []
        list_k.append(Pair(x:0, y:5))
        list_k.append(Pair(x:0, y:4))
        list_k.append(Pair(x:0, y:3))
        list_k.append(Pair(x:0, y:2))
        list_k.append(Pair(x:1, y:3))
        list_k.append(Pair(x:2, y:4))
        list_k.append(Pair(x:2, y:3))
        list_k.append(Pair(x:2, y:2))
        list_k.append(Pair(x:2, y:1))
        list_k.append(Pair(x:2, y:0))
        list_k.append(Pair(x:1, y:0))
        IndexDictionary["ک"] = list_k
        MaxCharIndexDictionary["ک"] = Pair(x:3, y:5);
        
        
        
        //۶ * ۴
        //۹
        var list_l:[Pair] = []
        list_l.append(Pair(x:0, y:3))
        list_l.append(Pair(x:1, y:3))
        list_l.append(Pair(x:2, y:3))
        list_l.append(Pair(x:3, y:3))
        list_l.append(Pair(x:4, y:3))
        list_l.append(Pair(x:5, y:2))
        list_l.append(Pair(x:5, y:1))
        list_l.append(Pair(x:4, y:0))
        list_l.append(Pair(x:3, y:0))
        IndexDictionary["ل"] = list_l
        MaxCharIndexDictionary["ل"] = Pair(x:5, y:3);
        
        
        //۵ * ۴
        //۹
        var list_m:[Pair] = []
        list_m.append(Pair(x:0, y:3))
        list_m.append(Pair(x:0, y:2))
        list_m.append(Pair(x:1, y:3))
        list_m.append(Pair(x:1, y:2))
        list_m.append(Pair(x:1, y:1))
        list_m.append(Pair(x:1, y:0))
        list_m.append(Pair(x:2, y:0))
        list_m.append(Pair(x:3, y:0))
        list_m.append(Pair(x:4, y:0))
        IndexDictionary["م"] = list_m
        MaxCharIndexDictionary["م"] = Pair(x:4, y:3);
        
        //۴ * ۵
        //۱۰
        var list_n:[Pair] = []
        list_n.append(Pair(x:0, y:4))
        list_n.append(Pair(x:1, y:4))
        list_n.append(Pair(x:2, y:4))
        list_n.append(Pair(x:3, y:3))
        list_n.append(Pair(x:3, y:2))
        list_n.append(Pair(x:3, y:1))
        list_n.append(Pair(x:2, y:0))
        list_n.append(Pair(x:1, y:0))
        list_n.append(Pair(x:0, y:0))
        list_n.append(Pair(x:1, y:2))
        IndexDictionary["ن"] = list_n
        MaxCharIndexDictionary["ن"] = Pair(x:3, y:4);
        
        //۵ * ۳
        //۷
        var list_v:[Pair] = []
        list_v.append(Pair(x:0, y:2))
        list_v.append(Pair(x:0, y:1))
        list_v.append(Pair(x:1, y:2))
        list_v.append(Pair(x:1, y:1))
        list_v.append(Pair(x:2, y:2))
        list_v.append(Pair(x:3, y:1))
        list_v.append(Pair(x:4, y:0))
        IndexDictionary["و"] = list_v
        MaxCharIndexDictionary["و"] = Pair(x:4, y:2);
        
        
        
        //۴ * ۴
        //۸
        var list_y:[Pair] = []
        list_y.append(Pair(x:0, y:3))
        list_y.append(Pair(x:0, y:2))
        list_y.append(Pair(x:1, y:2))
        list_y.append(Pair(x:2, y:3))
        list_y.append(Pair(x:3, y:2))
        list_y.append(Pair(x:3, y:1))
        list_y.append(Pair(x:2, y:0))
        list_y.append(Pair(x:1, y:0))
        IndexDictionary["ی"] = list_y
        MaxCharIndexDictionary["ی"] = Pair(x:3, y:3);
    }
    
}


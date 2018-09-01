//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/8/21.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit
import EmotionInput



class ViewController: UIViewController {
    
    let emotionList = [
        Emotion(["code": "", "name": "11", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "222", "imageName": "hot"]),
        Emotion(["code": "1", "name": "", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "4", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "5", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "6", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "7", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "8", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "9", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "10", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "11", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "12", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "13", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "14", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "15", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "16", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "17", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "18", "imageName": "avatar-anonymous.png"]),
        
        Emotion(["code": "1", "name": "19", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "20", "imageName": "hot"]),
        Emotion(["code": "1", "name": "21", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "22", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "23", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "24", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "25", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "26", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "27", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "28", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "29", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "30", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "31", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "32", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "33", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "34", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "35", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "36", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "37", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "38", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "39", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "40", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "41", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "42", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "43", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "44", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "45", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "46", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "47", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "48", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "49", "imageName": "avatar-anonymous.png"]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let emotionInput = EmotionInput(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 400))
        emotionInput.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        emotionInput.delegate = self
        view.addSubview(emotionInput)
        
        let emotionSet1 = EmotionSet.build(iconName: "hot", emotionList: emotionList, columns: 3, rows: 4, width: 40, height: 40, hasDeleteButton: true, hasIndicator: true)
        let emotionSet2 = EmotionSet.build(iconName: "hot", emotionList: emotionList, columns: 3, rows: 3, width: 40, height: 40, hasDeleteButton: false, hasIndicator: false)
        
        emotionInput.emotionSetList = [emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController: EmotionInputDelegate {
    
    func emotionInputDidSendClick(_ emotionInput: EmotionInput) {
        print("send click")
    }
    
    func emotionInputDidDeleteClick(_ emotionInput: EmotionInput) {
        print("delete click")
    }
    
    func emotionInputDidEmotionClick(_ emotionInput: EmotionInput, _ emotion: Emotion) {
        print("emotion click \(emotion.name)")
    }
}


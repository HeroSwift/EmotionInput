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
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "hot"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["code": "1", "name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        Emotion(["name": "开心", "imageName": "avatar-anonymous.png"]),
        
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let pager = EmotionPager(frame: view.frame)
        
        view.addSubview(pager)
        
        let emotionSet = EmotionSet.build(iconName: "", emotionList: emotionList, columns: 3, rows: 4, width: 40, height: 40, hasDeleteButton: true, hasIndicator: true)
        
        pager.emotionSet = emotionSet
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


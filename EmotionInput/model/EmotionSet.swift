//
//  EmotionSet.swift
//  EmotionInput
//
//  Created by zhujl on 2018/8/21.
//  Copyright © 2018年 finstao. All rights reserved.
//

import Foundation

class EmotionSet: NSObject {
    
    // 底部栏图标
    let iconId = 0
    
    // 该套表情的所有表情
    let emotionPageList = 0
    
    // 是否需要导航指示器
    let hasIndicator = false
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}


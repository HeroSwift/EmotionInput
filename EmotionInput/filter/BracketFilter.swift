//
//  BracketFilter.swift
//  EmotionInput
//
//  Created by zhujl on 2018/9/6.
//  Copyright © 2018年 finstao. All rights reserved.
//

import Foundation

public class BracketFilter: EmotionFilter {
    
    public init() {
        super.init("\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]")
    }
    
}

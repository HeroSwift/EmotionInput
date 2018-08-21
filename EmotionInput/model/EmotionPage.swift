
import Foundation

class EmotionPage: NSObject {
    
    // 每页的图标列表
    let emotionList = 0
    
    // 每页有多少列
    let columns = 0
    
    // 每页有多少行
    let rows = 0
    
    // 是否显示删除按钮
    let hasDeleteButton = false
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}


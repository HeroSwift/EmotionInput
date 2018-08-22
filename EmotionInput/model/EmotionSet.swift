
import Foundation

public class EmotionSet: NSObject {
    
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


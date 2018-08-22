
import Foundation

public class EmotionIcon: NSObject {
    
    // 当前是第几套图标
    let index = 0
    
    // 本地图标
    let resId = 0
    
    // 是否是选中状态
    let selected = false
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}

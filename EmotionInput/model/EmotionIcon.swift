
import Foundation

public class EmotionIcon: NSObject {
    
    // 当前是第几套图标
    @objc public var index = 0
    
    // 本地图标
    @objc public var iconName = ""
    
    // 是否是选中状态
    @objc public var selected = false
    
    public init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}

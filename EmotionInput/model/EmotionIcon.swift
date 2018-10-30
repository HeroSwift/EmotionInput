
public class EmotionIcon {
    
    // 当前是第几套图标
    public var index: Int
    
    // 本地图标
    public var iconName: String
    
    // 是否是选中状态
    public var selected: Bool
    
    public init(index: Int, iconName: String, selected: Bool) {
        self.index = index
        self.iconName = iconName
        self.selected = selected
    }
    
}

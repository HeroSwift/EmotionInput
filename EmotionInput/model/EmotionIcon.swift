
import UIKit

public class EmotionIcon {
    
    // 当前是第几套图标
    public var index: Int
    
    // 本地图标
    public var iconAsset: UIImage
    
    // 是否是选中状态
    public var selected: Bool
    
    public init(index: Int, iconAsset: UIImage, selected: Bool) {
        self.index = index
        self.iconAsset = iconAsset
        self.selected = selected
    }
    
}

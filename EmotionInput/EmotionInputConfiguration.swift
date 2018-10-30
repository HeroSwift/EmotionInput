import UIKit

// 配置
public class EmotionInputConfiguration {
    
    // indicator 与网格的距离
    public var indicatorMarginTop = CGFloat(8)
    
    // toolbar 与 indicator 的距离
    public var toolbarMarginTop = CGFloat(8)
    
    
    // 表情网格容器的上下 padding
    let gridPaddingVertical = CGFloat(20)
    
    // 表情网格容器的左右 padding
    let gridPaddingHorizontal = CGFloat(20)
    
    // 行间距
    let gridRowSpacing = CGFloat(10)
    
    // 列间距
    let gridColumnSpacing = CGFloat(10)
    
    // 删除图片
    let gridDeleteImageName = "delete-emotion"
    
    // 表情单元格按下时的背景色
    let cellBackgroundColorPressed = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
    
    
    // 单元格文本字体
    let cellNameTextFont: UIFont = UIFont.systemFont(ofSize: 12)
    
    // 单元格文本颜色
    let cellNameTextColor: UIColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
    
    // 单元格文本与表情的距离
    let cellNameMarginTop: CGFloat = 5
    
    
    
    public init() { }
    
}

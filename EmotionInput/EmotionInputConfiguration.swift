import UIKit

// 配置
public class EmotionInputConfiguration {
    
    // indicator 与网格的距离
    public var indicatorMarginTop = CGFloat(8)
    
    // toolbar 与 indicator 的距离
    public var toolbarMarginTop = CGFloat(8)
    
    // toolbar 背景色
    public var toolbarBackgroundColor = UIColor.white
    
    
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
    
    
    
    
    // 工具栏的高度
    let toolbarHeight = CGFloat(44)
    
    // 图标单元格宽度
    let toolbarCellWidth = CGFloat(44)
    
    // 表情单元格分割线颜色
    let toolbarCellDividerColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    
    // 表情单元格分割线宽度
    let toolbarCellDividerWidth: CGFloat = 1 / UIScreen.main.scale
    
    // 表情单元格分割线高度
    let toolbarCellDividerHeight: CGFloat = 32
    
    // 表情单元格按下时的背景色
    let toolbarCellBackgroundColorPressed = UIColor(red: 244 / 255, green: 242 / 255, blue: 246 / 255, alpha: 1)
    
    // 发送按钮的文本
    let sendButtonText = "发送"
    
    // 发送按钮的文本字体
    let sendButtonTextFont = UIFont.systemFont(ofSize: 14)
    
    // 发送按钮的文本颜色
    let sendButtonTextColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1)
    
    // 发送按钮左边框的大小
    let sendButtonLeftBorderWidth =  1 / UIScreen.main.scale
    
    // 发送按钮左边框的颜色
    let sendButtonLeftBorderColor = UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1)
    
    // 发送按钮的背景颜色
    let sendButtonBackgroundColor = UIColor(red: 249 / 255, green: 248 / 255, blue: 249 / 255, alpha: 1)
    
    // 发送按钮的左右内间距
    let sendButtonPaddingLeft = CGFloat(14)
    let sendButtonPaddingRight = CGFloat(14)
    
    
    public init() { }
    
}

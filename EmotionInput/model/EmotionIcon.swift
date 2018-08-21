
import Foundation

class EmotionIcon: NSObject {
    
    let index = 0
    
    let resId = 0
    
    let selected = false
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}

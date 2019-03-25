//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/8/21.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit
import EmotionInput


class Configuration: EmotionPagerConfiguration {
    
    override func loadImage(imageView: UIImageView, url: String) {
        
    }
    
}


class ViewController: UIViewController {

    let emotionList = [
        Emotion(code: "😄", name: "", localImage: UIImage(named: "emoji_1f604"), inline: true),
        Emotion(code: "😷", name: "", localImage: UIImage(named: "emoji_1f637"), inline: true),
        Emotion(code: "😂", name: "", localImage: UIImage(named: "emoji_1f602"), inline: true),
        Emotion(code: "😝", name: "", localImage: UIImage(named: "emoji_1f61d"), inline: true),
        Emotion(code: "😳", name: "", localImage: UIImage(named: "emoji_1f633"), inline: true),
        Emotion(code: "😱", name: "", localImage: UIImage(named: "emoji_1f631"), inline: true),
        Emotion(code: "😔", name: "", localImage: UIImage(named: "emoji_1f614"), inline: true),
        Emotion(code: "😒", name: "", localImage: UIImage(named: "emoji_1f612"), inline: true),
        Emotion(code: "🤗", name: "", localImage: UIImage(named: "emoji_1f917"), inline: true),
        Emotion(code: "🙂", name: "", localImage: UIImage(named: "emoji_1f642"), inline: true),
        Emotion(code: "😊", name: "", localImage: UIImage(named: "emoji_1f60a"), inline: true),
        Emotion(code: "😋", name: "", localImage: UIImage(named: "emoji_1f60b"), inline: true),
        Emotion(code: "😌", name: "", localImage: UIImage(named: "emoji_1f60c"), inline: true),
        Emotion(code: "😍", name: "", localImage: UIImage(named: "emoji_1f60d"), inline: true),
        Emotion(code: "😎", name: "", localImage: UIImage(named: "emoji_1f60e"), inline: true),
        Emotion(code: "😪", name: "", localImage: UIImage(named: "emoji_1f62a"), inline: true),
        Emotion(code: "😓", name: "", localImage: UIImage(named: "emoji_1f613"), inline: true),
        Emotion(code: "😭", name: "", localImage: UIImage(named: "emoji_1f62d"), inline: true),
        Emotion(code: "😘", name: "", localImage: UIImage(named: "emoji_1f618"), inline: true),
        Emotion(code: "😏", name: "", localImage: UIImage(named: "emoji_1f60f"), inline: true),
        Emotion(code: "😚", name: "", localImage: UIImage(named: "emoji_1f61a"), inline: true),
        Emotion(code: "😛", name: "", localImage: UIImage(named: "emoji_1f61b"), inline: true),
        Emotion(code: "😜", name: "", localImage: UIImage(named: "emoji_1f61c"), inline: true),
        
        
        Emotion(code: "💪", name: "", localImage: UIImage(named: "emoji_1f4aa"), inline: true),
        Emotion(code: "👊", name: "", localImage: UIImage(named: "emoji_1f44a"), inline: true),
        Emotion(code: "👍", name: "", localImage: UIImage(named: "emoji_1f44d"), inline: true),
        Emotion(code: "🤘", name: "", localImage: UIImage(named: "emoji_1f918"), inline: true),
        Emotion(code: "👏", name: "", localImage: UIImage(named: "emoji_1f44f"), inline: true),
        Emotion(code: "👋", name: "", localImage: UIImage(named: "emoji_1f44b"), inline: true),
        Emotion(code: "🙌", name: "", localImage: UIImage(named: "emoji_1f64c"), inline: true),
        Emotion(code: "🖐", name: "", localImage: UIImage(named: "emoji_1f590"), inline: true),
        Emotion(code: "🖖", name: "", localImage: UIImage(named: "emoji_1f596"), inline: true),
        Emotion(code: "👎", name: "", localImage: UIImage(named: "emoji_1f44e"), inline: true),
        Emotion(code: "🙏", name: "", localImage: UIImage(named: "emoji_1f64f"), inline: true),
        Emotion(code: "👌", name: "", localImage: UIImage(named: "emoji_1f44c"), inline: true),
        Emotion(code: "👈", name: "", localImage: UIImage(named: "emoji_1f448"), inline: true),
        Emotion(code: "👉", name: "", localImage: UIImage(named: "emoji_1f449"), inline: true),
        Emotion(code: "👆", name: "", localImage: UIImage(named: "emoji_1f446"), inline: true),
        Emotion(code: "👇", name: "", localImage: UIImage(named: "emoji_1f447"), inline: true),
        Emotion(code: "🎃", name: "", localImage: UIImage(named: "emoji_1f383"), inline: true),
        Emotion(code: "👀", name: "", localImage: UIImage(named: "emoji_1f440"), inline: true),
        Emotion(code: "👃", name: "", localImage: UIImage(named: "emoji_1f443"), inline: true),
        Emotion(code: "👄", name: "", localImage: UIImage(named: "emoji_1f444"), inline: true),
        Emotion(code: "👂", name: "", localImage: UIImage(named: "emoji_1f442"), inline: true),
        Emotion(code: "👻", name: "", localImage: UIImage(named: "emoji_1f47b"), inline: true),
        Emotion(code: "💋", name: "", localImage: UIImage(named: "emoji_1f48b"), inline: true),
        
        
        
        Emotion(code: "😞", name: "", localImage: UIImage(named: "emoji_1f61e"), inline: true),
        Emotion(code: "😟", name: "", localImage: UIImage(named: "emoji_1f61f"), inline: true),
        Emotion(code: "😫", name: "", localImage: UIImage(named: "emoji_1f62b"), inline: true),
        Emotion(code: "😮", name: "", localImage: UIImage(named: "emoji_1f62e"), inline: true),
        Emotion(code: "😯", name: "", localImage: UIImage(named: "emoji_1f62f"), inline: true),
        Emotion(code: "😉", name: "", localImage: UIImage(named: "emoji_1f609"), inline: true),
        Emotion(code: "😡", name: "", localImage: UIImage(named: "emoji_1f621"), inline: true),
        Emotion(code: "😢", name: "", localImage: UIImage(named: "emoji_1f622"), inline: true),
        Emotion(code: "😣", name: "", localImage: UIImage(named: "emoji_1f623"), inline: true),
        Emotion(code: "😤", name: "", localImage: UIImage(named: "emoji_1f624"), inline: true),
        Emotion(code: "😥", name: "", localImage: UIImage(named: "emoji_1f625"), inline: true),
        Emotion(code: "😧", name: "", localImage: UIImage(named: "emoji_1f627"), inline: true),
        Emotion(code: "😨", name: "", localImage: UIImage(named: "emoji_1f628"), inline: true),
        Emotion(code: "😩", name: "", localImage: UIImage(named: "emoji_1f629"), inline: true),
        Emotion(code: "😲", name: "", localImage: UIImage(named: "emoji_1f632"), inline: true),
        Emotion(code: "😴", name: "", localImage: UIImage(named: "emoji_1f634"), inline: true),
        Emotion(code: "😵", name: "", localImage: UIImage(named: "emoji_1f635"), inline: true),
        Emotion(code: "🙄", name: "", localImage: UIImage(named: "emoji_1f644"), inline: true),
        Emotion(code: "🤒", name: "", localImage: UIImage(named: "emoji_1f912"), inline: true),
        Emotion(code: "🤓", name: "", localImage: UIImage(named: "emoji_1f913"), inline: true),
        Emotion(code: "🤔", name: "", localImage: UIImage(named: "emoji_1f914"), inline: true),

    ]

    var textInput: EmotionTextarea!

    var emotionPager: EmotionPager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let configuration = Configuration()
        
        textInput = EmotionTextarea(configuration: EmotionTextareaConfiguration())
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.onTextChange = {
            print(self.textInput.plainText)
            self.emotionPager.isSubmitButtonEnabled = self.textInput.plainText != ""
        }

        view.addSubview(textInput)
        
        
        emotionPager = EmotionPager(configuration: configuration)
        emotionPager.translatesAutoresizingMaskIntoConstraints = false
        emotionPager.onSubmitClick = {
            print("send click \(self.textInput.plainText)")
            self.textInput.clear()
        }
        emotionPager.onEmotionClick = { emotion in
            print("emotion click \(emotion.name)")
            self.textInput.insertEmotion(emotion)
        }
        emotionPager.onDeleteClick = {
            self.textInput.deleteBackward()

//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.delegate = self
//            self.present(imagePicker, animated: true, completion: nil)
        }
        view.addSubview(emotionPager)

        let emotionSet1 = EmotionSet.build(localImage: UIImage(named: "emoji_icon")!, emotionList: emotionList, columns: 8, rows: 3, width: 24, height: 24, hasDeleteButton: true, hasIndicator: true)
        let emotionSet2 = EmotionSet.build(localImage: UIImage(named: "emoji_icon")!, emotionList: emotionList, columns: 3, rows: 3, width: 40, height: 40, hasDeleteButton: false, hasIndicator: false)

        emotionPager.emotionSetList = [emotionSet1, emotionSet2, emotionSet1 ]

        let filter = EmojiFilter(emotionList: emotionList)
        textInput.addFilter(filter)
        
        
        let textarea = UITextView()
        textarea.translatesAutoresizingMaskIntoConstraints = false
        textarea.backgroundColor = .gray
        view.addSubview(textarea)
        textarea.text = "123"
        
        view.addConstraints([
            
            NSLayoutConstraint(item: textarea, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20),
            NSLayoutConstraint(item: textarea, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textarea, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textarea, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50),
            
            NSLayoutConstraint(item: emotionPager, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -258),
            NSLayoutConstraint(item: emotionPager, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0),
            
            
            NSLayoutConstraint(item: textInput, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10),
            NSLayoutConstraint(item: textInput, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10),
            NSLayoutConstraint(item: textInput, attribute: .bottom, relatedBy: .equal, toItem: emotionPager, attribute: .top, multiplier: 1.0, constant: -10),

        ])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 拿到选择完的照片
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print(selectedImage)
    }
    
}


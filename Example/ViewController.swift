//
//  ViewController.swift
//  Example
//
//  Created by zhujl on 2018/8/21.
//  Copyright © 2018年 finstao. All rights reserved.
//

import UIKit
import EmotionInput



class ViewController: UIViewController {

    let emotionList = [
        Emotion(code: "", name: "开心", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "[1]", name: "开心开心开心开心", imageName: "hot", imageUrl: "", inline: true),
        Emotion(code: "[2]", name: "", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "[3]", name: "4", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "[4]", name: "5", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "6", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "7", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "8", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "9", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "10", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "11", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "12", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "13", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "14", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "15", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "16", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "17", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "", name: "18", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),

        Emotion(code: "1", name: "19", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "20", imageName: "hot", imageUrl: "", inline: true),
        Emotion(code: "1", name: "21", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "22", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "23", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "24", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "25", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "26", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "27", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "28", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "29", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "30", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "31", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "32", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "33", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "34", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "35", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "36", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "37", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "38", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "39", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "40", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "41", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "42", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "43", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "44", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "45", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "46", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "47", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "48", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
        Emotion(code: "1", name: "49", imageName: "avatar-anonymous.png", imageUrl: "", inline: true),
    ]

    var textInput: EmotionTextarea!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let configuration = EmotionInputConfiguration()
        
        textInput = EmotionTextarea(configuration: configuration)
        textInput.backgroundColor = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        textInput.translatesAutoresizingMaskIntoConstraints = false
        textInput.onTextChange = {
            print(self.textInput.plainText)
        }

        view.addSubview(textInput)
        
        
        let emotionPager = EmotionPager(configuration: configuration)
        emotionPager.translatesAutoresizingMaskIntoConstraints = false
        emotionPager.onSendClick = {
            print("send click \(self.textInput.plainText)")
            self.textInput.clear()
        }
        emotionPager.onEmotionClick = { emotion in
            print("emotion click \(emotion.name)")
            self.textInput.insertEmotion(emotion)
        }
        emotionPager.onDeleteClick = {
            self.textInput.deleteBackward()

            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        view.addSubview(emotionPager)

        let emotionSet1 = EmotionSet.build(iconName: "hot", emotionList: emotionList, columns: 5, rows: 4, width: 40, height: 40, hasDeleteButton: true, hasIndicator: true)
        let emotionSet2 = EmotionSet.build(iconName: "hot", emotionList: emotionList, columns: 3, rows: 3, width: 40, height: 40, hasDeleteButton: false, hasIndicator: false)

        emotionPager.emotionSetList = [emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2, emotionSet1, emotionSet2]

        let filter = BracketFilter(emotionList: emotionList)
        textInput.addFilter(filter)
        
        
        view.addConstraints([
            NSLayoutConstraint(item: textInput, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textInput, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: textInput, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 50),
            
            NSLayoutConstraint(item: emotionPager, attribute: .top, relatedBy: .equal, toItem: textInput, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -50),
        ])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //拿到选择完的照片
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(selectedImage)
    }
}


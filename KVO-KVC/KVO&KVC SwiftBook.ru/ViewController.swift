//
//  ViewController.swift
//  KVO&KVC SwiftBook.ru
//
//  Created by Алексей Пархоменко on 22/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

// MARK: -  1 шаг. создать class NSObject
class Person: NSObject{
    @objc dynamic var name = String() /// objc - потому что все процессы происходят в objective-c runtime и это нужно для того чтобы могли использовать свойства оттуда. dynamic - для того чтобы следить за изменениями
}


class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
   // MARK: - 2 шаг. вставить объект класса NSObject "name" в ViewController (обязательно @objc)
    @objc var taylor = Person()
    @objc dynamic var inputText: String?
    
    // MARK: - 4 шаг. Создаем наблюдателя который реализует функцию observe
    var nameObservation: NSKeyValueObservation?
    var inputTextObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
// MARK: - 3 шаг. Добавить observer для нашего класса Person
        nameObservation = observe(\ViewController.taylor.name, options: [.new, .old]) { (vc, change) in
         guard let updatedName = change.newValue else {return}
            ///как получили newValue приравняем его к nameLabel.text
            self.nameLabel.text = updatedName
            print("Новое значение String(describing: \(String(describing: change.newValue)) , старое значение \(String(describing: change.oldValue)) ")
        }
        
       inputTextObserver = observe(\ViewController.inputText, options: .new) { (vc, change) in
            guard let updatedText = change.newValue as? String else {return}
            vc.textLabel.text = updatedText
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        taylor.name = "Taylor"
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        inputText = textField.text
    }
    
}


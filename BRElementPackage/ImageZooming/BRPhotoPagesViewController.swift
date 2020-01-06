//
//  BRPhotoPagesViewController.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/5.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRPhotoPagesViewController: UIViewController {

    @IBOutlet weak var ShowImageView: UIImageView!
    @IBOutlet weak var ContentScrollView: UIScrollView!
    @IBOutlet weak var InputTextField: UITextField!

    @IBAction func hideKeyboard(_ sender : AnyObject){
        InputTextField.endEditing(true)
    }

    @IBAction func openZoomImage(_ sender : AnyObject){
        self.performSegue(withIdentifier: "toZoom", sender: nil)
    }

    var index:Int!

    var photoName : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let photoName = photoName {
            self.ShowImageView.image = UIImage(named: photoName)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    final private func manageKeyboardShow(_ show: Bool,notification : Notification){
        guard let into = notification.userInfo , let keyboardInfo = into[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let adjustHeight = (keyboardInfo.cgRectValue.height + 20) * (show ? 1 : -1)
        ContentScrollView.contentInset.bottom += adjustHeight
        ContentScrollView.verticalScrollIndicatorInsets.bottom += adjustHeight
    }

    @objc func keyboardWillShow(_ notification : Notification){
        manageKeyboardShow(true, notification: notification)
    }
    @objc func keyboardWillHide(_ notification : Notification){
        manageKeyboardShow(false, notification: notification)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZoom" , let toVc = segue.destination as? BRImageZoom{
            toVc.photoName = photoName
        }
    }
}

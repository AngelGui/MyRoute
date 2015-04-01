//
//  UIAlertCustomView.swift
//  MyRoute
//
//  Created by 陈桂 on 15/3/30.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

import Foundation
import UIKit

//
//  UIAlertView.h
//  UIKit
//
//  Copyright 2010-2012 Apple Inc. All rights reserved.
//

enum UIAlertViewStyle : Int {
    case Default
    case SecureTextInput
    case PlainTextInput
    case LoginAndPasswordInput
}

// UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead
@availability(iOS, introduced=2.0)
class UIAlertCustomView : UIView {
    
    init(title: String?, message: String?, delegate: AnyObject?, cancelButtonTitle: String?) /*<UIAlertViewDelegate>*/
    
    unowned(unsafe) var delegate: AnyObject? /*<UIAlertViewDelegate>*/ // weak reference
    var title: String
    var message: String? // secondary explanation text
    
    // adds a button with the title. returns the index (0 based) of where it was added. buttons are displayed in the order added except for the
    // cancel button which will be positioned based on HI requirements. buttons cannot be customized.
    func addButtonWithTitle(title: String) -> Int // returns index of button. 0 based.
    func buttonTitleAtIndex(buttonIndex: Int) -> String!
    var numberOfButtons: Int { get }
    var cancelButtonIndex: Int // if the delegate does not implement -alertViewCancel:, we pretend this button was clicked on. default is -1
    
    var firstOtherButtonIndex: Int { get } // -1 if no otherButtonTitles or initWithTitle:... not used
    var visible: Bool { get }
    
    // shows popup alert animated.
    func show()
    
    // hides alert sheet or popup. use this method when you need to explicitly dismiss the alert.
    // it does not need to be called if the user presses on a button
    func dismissWithClickedButtonIndex(buttonIndex: Int, animated: Bool)
    
    // Alert view style - defaults to UIAlertViewStyleDefault
    @availability(iOS, introduced=5.0)
    var alertViewStyle: UIAlertViewStyle
    
    /* Retrieve a text field at an index - raises NSRangeException when textFieldIndex is out-of-bounds.
    The field at index 0 will be the first text field (the single field or the login field), the field at index 1 will be the password field. */
    @availability(iOS, introduced=5.0)
    func textFieldAtIndex(textFieldIndex: Int) -> UITextField?
}

extension UIAlertView {
    convenience init(title: String, message: String, delegate: UIAlertViewDelegate?, cancelButtonTitle: String?, otherButtonTitles firstButtonTitle: String, _ moreButtonTitles: String...)
}

protocol UIAlertViewDelegate : NSObjectProtocol {
    
    // Called when a button is clicked. The view will be automatically dismissed after this call returns
    optional func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    
    // Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
    // If not defined in the delegate, we simulate a click in the cancel button
    optional func alertViewCancel(alertView: UIAlertView)
    
    optional func willPresentAlertView(alertView: UIAlertView) // before animation and showing view
    optional func didPresentAlertView(alertView: UIAlertView) // after animation
    
    optional func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) // before animation and hiding view
    optional func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) // after animation
    
    // Called after edits in any of the default fields added by the style
    optional func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool
}

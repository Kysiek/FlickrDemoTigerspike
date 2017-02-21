//
//  UIViewControllerExtension.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 21.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit
import TSMessages

enum InformationType {
    case error
    case success
    case warning
}

extension UIViewController {
    func showInformation(containing alertMessage: AlertMessage, type: TSMessageNotificationType) {
        TSMessage.showNotification(in: self.navigationController, title: alertMessage.title, subtitle: alertMessage.message, type: type)
    }
}


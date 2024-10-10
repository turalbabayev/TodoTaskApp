//
//  TextFieldHelper.swift
//  TodoTaskApp
//
//  Created by Tural Babayev on 10.10.2024.
//

import Foundation
import UIKit

class UIHelper{
    func customizeTextField(to textField: UITextField) {
        // Arama ikonu için bir UIImageView oluşturuyoruz
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .gray // İkonun rengini ayarlıyoruz (isteğe bağlı)

        // İkonu içeren bir view (padding için)
        let iconContainerView: UIView = UIView(frame: CGRect(x: 25, y: 0, width: 40, height: 30))
        searchIcon.frame = CGRect(x: 20, y: 5, width: 20, height: 20) // İkonun boyutunu ayarlıyoruz
        iconContainerView.addSubview(searchIcon)

        // Sol tarafa ikon eklemek için ayar
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 25
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 0.2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
    }
}

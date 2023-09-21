//
//  PageCell.swift
//  NetSepet
//
//  Created by Şükrü Şimşek on 11.06.2023.
//

import UIKit

class PageCell: UICollectionViewCell {
    var page: Page? {
        didSet{
            guard let unwrappedPage = page else { return }
            
            deliveryImageFirst.image = UIImage(named: page!.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText,attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            
            
        }
    }
    
    
    let deliveryImageFirst: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "delivery_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }() //Bu son anon. funcs olur.
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Hızlı Teslimat",attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nTüm Türkiye'de 1 Günde Teslimat Garantisi Veren İlk E-Ticaret Uygulaması", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        topImageContainerView.addSubview(deliveryImageFirst)
        deliveryImageFirst.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        deliveryImageFirst.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        deliveryImageFirst.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SwippingController.swift
//  NetSepet
//
//  Created by Şükrü Şimşek on 11.06.2023.
//

import UIKit

class SwippingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "delivery_first", headerText: "\n\n\nTüm Türkiye'de 1 Günde Teslimat Garantisi Veren İlk E-Ticaret Uygulaması", bodyText: "Tüm Türkiye'de bulunan güçlü kargo ağımız ile akşam 17:00'a kadar verilen tüm siparişleriniz ertesi gün kapınızda!!"),
        Page(imageName: "megaphone_second", headerText: "\n\n\nFiyatlar Hakkında Sürekli Duyuru", bodyText: "En uygun fiyatları sizlere sunabilmek için sizlere fiyatlar hakkında bildirimler atıyoruz"),
        Page(imageName: "payments_third", headerText: "\n\n\nHer Türlü Ödeme Aracını Destekleyen Tek Platform", bodyText: "Kripto paralar da dahil olmak üzere tüm kredi kartları,banka kartları geçerlidir!!"),
        Page(imageName: "options_fourth", headerText: "\n\n\nEn Basit Ürün Karşılaştırma Sistemi", bodyText: "Ürünleri karşılaştırmanız için özel tasarlanan sistemimizde uygulamamız sizin için uygun ürünleri sizlere sunmaktadır."),
        Page(imageName: "sale_fifth", headerText: "\n\n\nEn Hızlı Şekilde Aradığını Bul!!", bodyText: "Algoritmamız sayesinde istediğiniz ürünleri en hızlı şekilde bulabilirsiniz.")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Geri", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(rgb: 0x321916), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    @objc private func handlePrevious(){
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x454677), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    private lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.currentPage = 0
        pageC.numberOfPages = pages.count
        
        pageC.currentPageIndicatorTintColor = UIColor(rgb: 0xfa8072)
        pageC.pageIndicatorTintColor = UIColor(rgb: 0xfcb2aa)
        return pageC
    }()
    
    
    func setupBottomControls(){
     
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)

        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
       
        
        
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
        
        if pageControl.currentPage == 4{
            let loginViewController = LogInSignUpController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
            
            //nextButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            //if nextButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        //cell.deliveryImageFirst.image = UIImage(named: page.imageName)
        //cell.descriptionTextView.text = page.headerText
        cell.page = page
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}



//
//  TabsViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 30.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import Foundation
import UIKit

struct PageModel{
    var name: String
    var label: UILabel? = nil
    var vc: UIViewController? = nil
}

protocol TabsViewControllerDelegate{
    func tabChanged(index: Int)
}

class TabsViewController: UIViewController {
    
    var pages: [PageModel] = []
    var delegate: TabsViewControllerDelegate?
    var textColor: UIColor = NerdeYesemColors.textDarkColor()
    var disabledTextColor: UIColor = NerdeYesemColors.brownGrey()
    
    var tabLabelTopMargin: CGFloat = 88.0
    var tabLabelLeftMargin: CGFloat = 16.0
    var tabLabelHeight: CGFloat = 30.0
    var tabLabelWidth: CGFloat = 60.0
    var tabIndicatorLeftMargin: CGFloat = 16.0
    var tabIndicatorHeight: CGFloat = 3.0
    var tabIndicatorWidth: CGFloat = 20.0
    var collectionViewBottomMargin: CGFloat = 88.0
    
    var tabIndicatorLeftConstraint: NSLayoutConstraint? = nil
    var scrollView: UIScrollView? = nil
    private var isAnimatingScroll: Bool = false
    var lastScrolledPageIndex: Int = 0
    
    var isHome: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        calculateMargins()
        setUI()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scrollToIndex(index: lastScrolledPageIndex, animated: false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (context) in
            self.setViewControllerSizes()
        }
    }
    
    override func viewDidLayoutSubviews() {
        if showAnims{
            super.viewDidLayoutSubviews()
            setViewControllerSizes()
        }else{
            scrollToIndex(index: lastScrolledPageIndex, animated: false)
        }
    }
    
    func setViewControllerSizes(){
        for i in 0..<self.pages.count{
            let page = self.pages[i]
            let size = scrollView?.frame.size.width ?? self.view.frame.size.width
            var frame = CGRect(x: CGFloat(i) * (size), y: 0, width: size, height: self.view.frame.height)
            if (self.tabBarController?.tabBar.frame.height) != nil {
                frame.size.height = frame.height - (self.isHome ? 0.0 : 32.0)
            }
            page.vc?.view.frame = frame
        }
    }
    
    private func calculateMargins(){
        let navHeight = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        let safeAreaHeightTop = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
        tabLabelTopMargin = navHeight + safeAreaHeightTop
        
        

        let safeAreaBottomHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        collectionViewBottomMargin =  safeAreaBottomHeight
        collectionViewBottomMargin = 0.0
    }
    
    private func setUI(){
        view.backgroundColor = .white
        addTabLabelView()
        addTabIndicatorView()
        addScrollView()
    }
    
    private func addTabLabelView(){
        var previousLabel: UILabel? = nil
        var constraints: [NSLayoutConstraint] = []
        for i in 0..<pages.count{
            let page = pages[i]
            let label = UILabel()
            view.addSubview(label)
            label.text = page.name
            label.textColor = textColor
            label.isUserInteractionEnabled = true
            label.isEnabled = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tag = i
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabSelected)))
            if i == 0 {
                activateTab(label: label)
            }else{
                deactivateTab(label: label)
            }
            pages[i].label = label
            
            //Add constraints
            constraints.append(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: tabLabelTopMargin))
            constraints.append(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: tabLabelHeight))
            constraints.append(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: tabLabelWidth))
            
            
            if let previousLabel = previousLabel{
                //Not first element, consraint to previous element.
                constraints.append(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: previousLabel, attribute: .right, multiplier: 1.0, constant: tabLabelLeftMargin))
            }else{
                //First element, constraint to parent.
                constraints.append(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: tabLabelLeftMargin))
            }
            
            previousLabel = label
        }
        
        view.addConstraints(constraints)
    }
    
    func activateTab(label: UILabel){
        label.textColor = textColor
        label.font = UIFont.init(name: "Montserrat-Bold", size: 12.0)
    }
    
    func deactivateTab(label: UILabel){
        label.textColor = disabledTextColor
        label.font = UIFont.init(name: "Montserrat-Regular", size: 12.0)
    }
    
    @objc func tabSelected(sender: UITapGestureRecognizer){
        guard let selectedIndex = sender.view?.tag else { return }
         
        scrollToIndex(index: selectedIndex)
    }
    
    private func addTabIndicatorView(){
        let tabIndicatorView = UIView()
        tabIndicatorView.backgroundColor = textColor
        tabIndicatorView.layer.cornerRadius = 2.0
        tabIndicatorView.layer.masksToBounds = true
        view.addSubview(tabIndicatorView)
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: tabIndicatorView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: (tabLabelTopMargin + tabLabelHeight))
        tabIndicatorLeftConstraint = NSLayoutConstraint(item: tabIndicatorView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: tabIndicatorLeftMargin)
        let heightConstraint = NSLayoutConstraint(item: tabIndicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: tabIndicatorHeight)
        let widthConstraint = NSLayoutConstraint(item: tabIndicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: tabIndicatorWidth)
        
        view.addConstraints([topConstraint, tabIndicatorLeftConstraint!, heightConstraint, widthConstraint])
    }
    
    private func addScrollView(){
        scrollView = UIScrollView(frame: CGRect.zero)
        view.addSubview(scrollView!)
        scrollView?.translatesAutoresizingMaskIntoConstraints = false
        scrollView?.backgroundColor = .white
        scrollView?.isScrollEnabled = true
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        rightSwipe.direction = .right
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
        leftSwipe.direction = .left
        scrollView?.addGestureRecognizer(rightSwipe)
        scrollView?.addGestureRecognizer(leftSwipe)
        scrollView?.isPagingEnabled = true
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        //Add constraints
        let topConstraint = NSLayoutConstraint(item: scrollView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: self.isHome ? 0.0 : (tabLabelTopMargin + tabLabelHeight + tabIndicatorHeight))
        let leftConstraint = NSLayoutConstraint(item: scrollView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: scrollView!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: scrollView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: self.isHome ? 0.0 : collectionViewBottomMargin)
        
        self.view.addConstraints([topConstraint, leftConstraint, rightConstraint, bottomConstraint])
        
        initScrollView()
    }
    
    @objc func rightSwiped(){
        //Go previous screen.
        if isAnimatingScroll{
            return
        }
        
        let index = getCurrentScreenIndex()
        
        if index == 0{
            return
        }else{
            scrollToIndex(index: index - 1)
        }
    }
    
    @objc func leftSwiped(){
        //Go next screen.
        if isAnimatingScroll{
            return
        }
        
        let index = getCurrentScreenIndex()
        if index == self.pages.count - 1{
            return
        }else{
            scrollToIndex(index: index + 1)
        }
    }
    
    func scrollToIndex(index: Int, animated: Bool = true){
         lastScrolledPageIndex = index
        if animated{
            isAnimatingScroll = animated
        }
        
        scrollView?.setContentOffset(CGPoint(x: CGFloat(index) * (scrollView?.frame.size.width ?? 0.0), y: 0.0), animated: animated)
    }
    
    var showAnims: Bool = true
    func toggleAnims(showAnims: Bool){
        self.showAnims = showAnims
    }
    
    func tabChanged(index: Int){
        
    }
}

//MARK: UISCROLL VIEW DELEGATE
extension TabsViewController: UIScrollViewDelegate{
    
    func initScrollView(){
                
        scrollView?.delegate = self
        
        for i in 0..<pages.count{
            let page = pages[i]
            if let vc = page.vc{
                vc.view.isUserInteractionEnabled = true
                vc.view.translatesAutoresizingMaskIntoConstraints = true
                self.addChild(vc)
                scrollView?.addSubview(vc.view)
                vc.willMove(toParent: self)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollView {
            let offset = scrollView.contentOffset.x
//            let a = (tabLabelWidth + tabLabelLeftMargin)/scrollView.frame.width
//            tabIndicatorLeftConstraint?.constant = (offset * a) + tabLabelLeftMargin
            
            if Int(offset) % Int(scrollView.frame.width) == 0 {
                let selectedIndex = Int(offset/scrollView.frame.width)
                for i in 0..<pages.count{
                    let page = pages[i]
                    if let label = page.label{
                        if i == selectedIndex{
                            // In order to align leading the tab title with tab indicator
                            tabIndicatorLeftConstraint?.constant = label.frame.minX
                            activateTab(label: label)
                        }else{
                            deactivateTab(label: label)
                        }
                    }
                }
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.isAnimatingScroll = false
        let index = getCurrentScreenIndex()
        self.lastScrolledPageIndex = index
        self.delegate?.tabChanged(index: index)
        self.tabChanged(index: index)
    }
    
    func getCurrentScreenIndex() -> Int{
        guard let offset = scrollView?.contentOffset.x else { return 0 }
        guard let width = scrollView?.frame.width else { return 0 }
        
        let index = Int(offset / width)
        return index
    }
}


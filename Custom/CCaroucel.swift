//
//  CCaroucel.swift
//  myOrder
//
//  Created by Apple on 20/03/2019.
//  Copyright © 2019 Manu. All rights reserved.
//

import UIKit


protocol CCaroucelProtocol: NSObjectProtocol {
    
    func numberOfItems() -> Int
    func didSelectedItem(index: Int) -> Void
    
}

let selectionCornerRadius = CGFloat(22.0)

class CCaroucel: UIView {

    weak var rCaroucelProtocol:CCaroucelProtocol? = nil
    var fontSize = pixelToPoints(px: 30.0)
    var selectedIndex:Int = -1 {
        didSet{
            
            self.selectItem(index: selectedIndex, shouldCallProtocol: false)
        }
    }
    
    fileprivate var constraintSelectionCenterY:NSLayoutConstraint!
    fileprivate var constraintSelectionHeight: NSLayoutConstraint!
    fileprivate var constraintSelectionLeft:NSLayoutConstraint!
    fileprivate var constraintSelectionWidth:NSLayoutConstraint!
    fileprivate var views:[UIView] = []
    fileprivate var labels:[UIImageView] = []
    fileprivate var prevLblsSelected:[UIImageView?] = []
    fileprivate let scrollView: UIScrollView? = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    fileprivate let viewSelection: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red:0.12, green:0.25, blue:0.5, alpha:1)
        v.layer.masksToBounds = false
        v.clipsToBounds = true
        return v
    }()
    
 
    
    // #1
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      //  setupView()
    }
    
    public override func didMoveToSuperview() {
        
        print("didMoveToSuperview %ld, [%ld]", clock(), CLOCKS_PER_SEC  )
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        print("layoutSubviews %ld, [%ld]", clock(), CLOCKS_PER_SEC  )
        setupView()

    }
    // #2
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    // #3
    public convenience init(image: UIImage, title: String) {
        self.init(frame: .zero)
        
        setupView()
    }
    
    public func reloadData(){
        
        setupView()
    }
    private func setupView() {
    
        if (rCaroucelProtocol == nil ) { return }
        
        print ("setupView was called")
        let noViews = rCaroucelProtocol?.numberOfItems()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var prevView:UIView? = nil
        
        if let scv = self.scrollView {
            scv.removeFromSuperview()
            for tmpView in self.views {
                tmpView.removeFromSuperview()
                tmpView.isHidden = true
            }
            self.views.removeAll()
            self.labels.removeAll()
        }
        scrollView?.alwaysBounceVertical = false
        scrollView?.bounces = false
        scrollView?.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView!)
        // constrain the scroll view to 8-pts on each side
        scrollView?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        scrollView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        scrollView?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        scrollView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true

        
        let rFont = UIFont(name: "Roboto-Regular", size: CGFloat(fontSize))
        
        for viewIdx in 0..<noViews! {
            
//            print("we are adding view \(viewIdx)")
            let newView: UIView = {
                let v = UIView()
                v.backgroundColor = .clear //colors[viewIdx]
                v.tag = viewIdx
                v.translatesAutoresizingMaskIntoConstraints = false
                return v
            }()

            
            scrollView?.addSubview(newView)
            
            //var txtWidth = itemText?.widthWithConstrainedHeight(100.0, font: rFont!)
           // txtWidth = txtWidth! + CGFloat(2 * selectionCornerRadius)
            
            // give each view a height of 300
            NSLayoutConstraint.activate([
                newView.heightAnchor.constraint(equalToConstant: self.bounds.height - 16.0),
                ])

            // give each view a width constraint equal to scrollView's width
            NSLayoutConstraint.activate([
                newView.widthAnchor.constraint(equalToConstant: 200),
                ])
            
            // constrain each view's leading and trailing to the scrollView
            // this also defines the width of the scrollView's .contentSize
            NSLayoutConstraint.activate([
                newView.topAnchor.constraint(equalTo: scrollView!.topAnchor),
                newView.bottomAnchor.constraint(equalTo:scrollView!.bottomAnchor),
                ])
            
            if let pv = prevView {
                
                NSLayoutConstraint.activate([
                    newView.leftAnchor.constraint(equalTo: pv.rightAnchor, constant: 8.0),
                    ])
                
            }else{
                NSLayoutConstraint.activate([
                    newView.leftAnchor.constraint(equalTo: scrollView!.leftAnchor, constant: 8.0),
                    ])
            }
             prevView = newView
            
            if viewIdx == noViews! - 1 {
                
                // constrain blueView's Bottom to scrollView's Bottom + 8-pts padding
                // this also defines the Bottom / Height of the scrollView's .contentSize
                // Note: it must be negative
                NSLayoutConstraint.activate([
                    newView.rightAnchor.constraint(equalTo: scrollView!.rightAnchor, constant: -28.0),
                    ])
                
            }
            let tapSearch = UITapGestureRecognizer(target: self, action:  #selector (self.searchTapped (_:)))
            let newLabel: UIImageView = {
                let imgView = UIImageView()
                imgView.backgroundColor = .clear
                imgView.tag = viewIdx
                imgView.isUserInteractionEnabled = true
                imgView.addGestureRecognizer(tapSearch)
                imgView.translatesAutoresizingMaskIntoConstraints = false
                
                return imgView
            }()
            
          newView.addSubview(newLabel)
            NSLayoutConstraint.activate([
                newLabel.topAnchor.constraint(equalTo: newView.topAnchor),
                newLabel.bottomAnchor.constraint(equalTo:newView.bottomAnchor),
                newLabel.leadingAnchor.constraint(equalTo:newView.leadingAnchor),
                newLabel.trailingAnchor.constraint(equalTo:newView.trailingAnchor),
                ])
            
            // keep track of them
            self.views.append(newView)
            self.labels.append(newLabel)

        
        
        } // end adding all views to scrollView
        
        
        
       
        scrollView?.addSubview(self.viewSelection)
        scrollView?.sendSubviewToBack(self.viewSelection)
    }
    
    // or for Swift 4
    @objc func searchTapped(_ sender:UITapGestureRecognizer){
        
        if let lbl = sender.view as? UILabel {
            
            let labelIdx = lbl.tag
            selectItem(index: labelIdx, shouldCallProtocol: true)
        }
    }
    
    private func resetPrevSelections() {
        
        // Deselect any previous (more than one) selected label
        for lbl in self.prevLblsSelected {
            
//             print("label [%d] made white %ld, [%ld]", lbl?.tag ?? "", clock(), CLOCKS_PER_SEC)
            //lbl?.textColor = .gray
        }
        
        self.prevLblsSelected.removeAll()
        
    }
    
    private func selectItem(index: Int, shouldCallProtocol:Bool) {
        
//        print("selectItem [%d] [%d] %ld, [%ld]", index, shouldCallProtocol, clock(), CLOCKS_PER_SEC)
        
       if index >= self.labels.count { return }
        
        let labelSender = self.labels[index]
            
        if shouldCallProtocol {
            
            self.rCaroucelProtocol?.didSelectedItem(index: index)
            
        }
        
        // Deselect any previous (more than one) selected label
        let prevLblSelected =  self.prevLblsSelected.popLast() as? UILabel
        self.resetPrevSelections()
    
        let viewCrt = self.views[index]
  
        if constraintSelectionCenterY != nil {
            constraintSelectionCenterY.isActive = false
            constraintSelectionHeight.isActive = false
            constraintSelectionLeft.isActive = false
            constraintSelectionWidth.isActive = false
        }
        self.constraintSelectionCenterY = self.viewSelection.centerYAnchor.constraint(equalTo: viewCrt.centerYAnchor, constant: 0.0)
        self.constraintSelectionHeight = self.viewSelection.heightAnchor.constraint(equalToConstant: self.fontSize * 2)
        self.constraintSelectionLeft = self.viewSelection.centerXAnchor.constraint(equalTo: viewCrt.centerXAnchor, constant: 0.0)
        self.constraintSelectionWidth = self.viewSelection.widthAnchor.constraint(equalTo: viewCrt.widthAnchor,multiplier: 1.1)
        
        self.viewSelection.layer.cornerRadius = self.fontSize
        
        UIView.animate(withDuration: 0.5) {
            print ("Activate selection motion")
            NSLayoutConstraint.activate([
                self.constraintSelectionCenterY,
                self.constraintSelectionHeight,
                self.constraintSelectionLeft,
                self.constraintSelectionWidth,
                ])

            self.scrollView!.layoutIfNeeded()
            
        }
        
        let frmSel = self.views[index].frame
        let bnds = self.bounds
        let deltaX = (bnds.width - frmSel.width) / 2
        var newX = frmSel.minX - deltaX
        
        if newX < 0 {
            
            newX = 0
        }
        
        let maxX = (self.scrollView?.contentSize.width ?? 0.0)  - bnds.width
        if maxX < newX {
            
            newX = maxX
            
        }
        
        UIView.transition(with: labelSender, duration: 0.5, options: .transitionCrossDissolve, animations: {

            //labelSender.textColor = .white
//            print(String(format:"label [%d] made white %ld, [%ld]", labelSender.tag, clock(), CLOCKS_PER_SEC))
            self.scrollView?.setContentOffset(CGPoint(x: newX, y: CGFloat(0.0)), animated: true)
            
            
        }, completion: { complete in
            
            self.prevLblsSelected = self.prevLblsSelected.filter { $0?.tag != labelSender.tag }
            self.resetPrevSelections()
            self.prevLblsSelected.append(labelSender)
            
            
        })


    }
}


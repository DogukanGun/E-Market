//
//  HudView.swift
//  E-Market
//
//  Created by Dogukan Ali Gundogan on 20.10.2021.
//
import UIKit

class HudView:UIView{
    var text = ""
    
    class func hudView(inView view:UIView,animated:Bool)->HudView{
        let hudView = HudView(frame: view.bounds)
        //isOpaque methodu arka plani siyah olmasini engeller hud view disinda kalan arka planin
        hudView.isOpaque = false
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        hudView.show(animated: animated)
//        hudView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        return hudView
    }
    func show(animated:Bool){
        if animated{
            alpha=0
            transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.alpha=1
                self.transform = CGAffineTransform.identity
            }, completion:nil )
        }
    }
    //bu birkere cizer siz aynisini tekrar isterseneiz setNeedsDisplay methodu kullanilir
    override func draw(_ rect: CGRect) {
        let boxWidth: CGFloat = 96
        let boxHeight: CGFloat = 96
        let boxRect = CGRect(x: round((bounds.width - boxWidth)/2), y: round((bounds.height-boxWidth)/2), width: boxWidth, height: boxHeight)
        
        let roundedRectangle = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        
        //set fill sonraki cizimlerde bu renk kullaniclacak demek
        UIColor(white: 0.3, alpha: 0.8).setFill()
        //set fill dedigimiz icin fill denince direk o renk geldi
        roundedRectangle.fill()
        let image_:UIImage
        if let image = UIImage(systemName: "checkmark"){
            image_=image
        } else {
            image_ = UIImage(systemName: "star")!
        }
        
        //image in cizilecegi nokta
        let imagePoint = CGPoint(x: center.x - round(image_.size.width/2), y: center.y - round(image_.size.height/2)-boxHeight/8)
        
        //image nereye cizilecek
        image_.draw(at: imagePoint)
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
        
        let textSize = text.size(withAttributes: attributes)
        
        let textPoint = CGPoint(x: center.x-round(textSize.width/2), y: center.y-round(textSize.height/2)+boxHeight/4)
        
        text.draw(at:textPoint,withAttributes:attributes)
        
        
    }
    
    func hide(){
        superview?.isUserInteractionEnabled = true
        removeFromSuperview()
    }
}

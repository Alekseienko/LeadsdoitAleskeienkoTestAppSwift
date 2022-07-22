//
//  GameVC.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 08.07.2022.
//

import UIKit
import Foundation


class GameVC: UIViewController {
    
    @IBOutlet weak var pickersView: UIPickerView!
    @IBOutlet weak var spinBackground: UIView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankLabelBacground: UIView!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var stepperBet: GMStepper!
    @IBOutlet weak var infoLabel: UILabel!
    
    var currentGame: SlotModel?
    var currentBank: Int = UserScore().getScore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "myHomeButton")?.withRenderingMode(.alwaysOriginal), style:.plain, target: self, action: #selector(back))
        
        navigationController?.navigationBar.isTranslucent = true
        
        pickersView.dataSource = self
        pickersView.delegate = self
        pickersView.isUserInteractionEnabled = false
        
        spinBackground.round(corners: [.topLeft], cornerRadius: 100)
        
        bankLabelBacground.round(corners: .allCorners, cornerRadius: 3)
        bankLabelBacground.layerGradient(startPoint: .centerLeft, endPoint: .centerRight, colorArray: [UIColor(red: 0.953, green: 0.651, blue: 0.306, alpha: 1).cgColor,UIColor(red: 0.929, green: 0.471, blue: 0.247, alpha: 1).cgColor], type: .axial)
        spinButton.setImage(UIImage(named: "spinButton"), for: .normal)
        bankLabel.text = String(currentBank)
        stepperBet.maximumValue = Double(currentBank / 2)
    }
    
    // MARK: - Orientation VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    // MARK: - Spin button
    @IBAction func spinButtonPresssed(_ sender: Any) {
        
        let beforeRotatingBank = currentBank
        if currentBank > 0 {
            var slotLine: [Int] = []
            for i in 0..<currentGame!.countLines {
                pickersView.selectRow((currentGame?.randomSlot())!, inComponent: i, animated: true)
                slotLine.append(Int(pickersView.selectedRow(inComponent: i)))
            }
            currentBank = (currentGame?.equalInLine(lineArray: slotLine, currentBank: currentBank, currentBet: stepperBet.value))!
            bankLabel.text = String(currentBank)
        }
        let afterRotatingBank = currentBank
        if currentBank <= 0 {
            bankLabel.text = "Game over"}
        else {
            infoLabel.text = currentGame?.infoLabelText(before: beforeRotatingBank, after: afterRotatingBank)
            stepperBet.maximumValue = Double(currentBank)
        }
        UserScore().setScores(value: currentBank)
    }
    
    // MARK: - Home button send to mainVC
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        
    }
}
// MARK: - PickerView settings

extension GameVC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return currentGame!.countLines
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (currentGame?.pikerImageLine().count)!
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return (pickersView.bounds.height / CGFloat((currentGame?.slotImageArray.count)!))*2
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (pickersView.bounds.width / CGFloat((currentGame?.slotImageArray.count)!))*1.5
    }
}

extension GameVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView()
        let wi = (pickersView.bounds.width / CGFloat((currentGame?.slotImageArray.count)!))*2
        let he = (pickersView.bounds.height / CGFloat((currentGame?.slotImageArray.count)!))*2
        
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: wi, height: he))
        myImageView.image = UIImage(named: (currentGame?.pikerImageLine()[row])!)?.withRenderingMode(.alwaysOriginal)
        myImageView.contentMode = .scaleAspectFit
        myView.addSubview(myImageView)
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let position = (currentGame?.slotImageArray.count)!/2 + row
        pickersView.selectRow(position, inComponent: 0, animated: false)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row % 10)
    }
}

// MARK: - Extension UIview Round corenrs

extension UIView {
    func round(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
    }
}

// MARK: - Extension UIview gradient

public enum CAGradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}

extension CAGradientLayer {
    convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.frame.origin = CGPoint.zero
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

extension UIView {
    func layerGradient(startPoint:CAGradientPoint, endPoint:CAGradientPoint ,colorArray:[CGColor], type:CAGradientLayerType ) {
        let gradient = CAGradientLayer(start: .topLeft, end: .topRight, colors: colorArray, type: type)
        gradient.frame.size = self.frame.size
        self.layer.insertSublayer(gradient, at: 0)
    }
}



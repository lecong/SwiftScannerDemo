//
//  ViewController.swift
//  QRCodeScanner
//
//  Created by Le Ngoc Cong on 04/03/2022.
//

import UIKit
import swiftScan

class ViewController: LBXScanViewController, QRRectDelegate, LBXScanViewControllerDelegate {
    
    var btnStartScanner: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.autoStart = false
        
        self.setupScanerStyle()
        
        self.delegate = self
        self.scanResultDelegate = self
    }
    
    func setupScanerStyle() {
        var style = LBXScanViewStyle()
        style.isNeedShowRetangle = false
        style.colorAngle = UIColor.white
        style.photoframeLineW = 1.0
        style.animationImage = UIImage(named: "qrcode_scan_light_green")
        style.anmiationStyle = LBXScanViewAnimationStyle.LineMove
        self.scanStyle = style
    }

    @objc func btnStartScanClicked() {
        self.startScan()
        btnStartScanner.isEnabled = false
    }
    
    //MARK: - QRRectDelegate
    func drawwed() {
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        let btnWidth = 480;
        let btnHeight = 108;
        
        
        btnStartScanner.bounds = CGRect(x: 0, y: 0, width: Int(btnWidth), height: btnHeight)
        btnStartScanner.center = CGPoint(x: self.view.frame.size.width/2, y: yMax - 150)
        btnStartScanner.setImage(UIImage(named: "btn_start_scan"), for: .normal)
        btnStartScanner.setImage(UIImage(named: "btn_start_scan_disabled"), for: .disabled)
        btnStartScanner.addTarget(self, action: #selector(btnStartScanClicked), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(btnStartScanner)
    }
    
    //MARK: - LBXScanViewControllerDelegate
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        if ((error) != nil) {
            let alertContoller = UIAlertController (title: "ERROR" , message: error, preferredStyle: UIAlertController.Style.alert)
            alertContoller.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default , handler: nil))
            self.present(alertContoller, animated: true, completion: nil)
        } else {
            let alertContoller = UIAlertController (title: "Scan success" , message: scanResult.strScanned, preferredStyle: UIAlertController.Style.alert)
            alertContoller.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default , handler: nil))
            self.present(alertContoller, animated: true, completion: nil)
        }
        
        btnStartScanner.isEnabled = true
    }
}


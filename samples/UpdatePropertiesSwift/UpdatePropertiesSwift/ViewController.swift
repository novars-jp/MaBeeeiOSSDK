//
//  ViewController.swift
//  UpdatePropertiesSwift
//
//  Created by Takeshi Shoji on 2016/08/18.
//  Copyright © 2016年 Novars Inc. All rights reserved.
//

import UIKit
import MaBeeeSDK

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().addObserver(self, selector: #selector(ViewController.receiveNotification(_:)))
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    MaBeeeApp.instance().removeObserver(self)
  }

  func receiveNotification(notification: NSNotification) {
    switch notification.name {
    case MaBeeeDeviceRssiDidUpdateNotification:
      if let identifier = notification.userInfo?["MaBeeeDeviceIdentifier"] as? UInt,
        device = MaBeeeApp.instance().deviceWithIdentifier(identifier) {
          appendLine(device.name + " RSSI : " + String(device.rssi))
        }
    case MaBeeeDeviceBatteryVoltageDidUpdateNotification:
      if let identifier = notification.userInfo?["MaBeeeDeviceIdentifier"] as? UInt,
        device = MaBeeeApp.instance().deviceWithIdentifier(identifier) {
        appendLine(device.name + " Volgate : " + String(device.batteryVoltage))
      }
    default:
      print(notification.name)
    }
  }

  func appendLine(line: String) {
    textView.text = textView.text + line + "\n"
  }

  @IBAction func scanButtnPressed(sender: UIButton) {
    let vc = MaBeeeScanViewController()
    vc.show(self)
  }

  @IBAction func updateButtonPressed(sender: UIButton) {
    for device in MaBeeeApp.instance().devices() {
      device.updateRssi()
      device.updateBatteryVoltage()
    }
  }
}


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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().addObserver(self, selector: #selector(ViewController.receiveNotification(_:)))
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    MaBeeeApp.instance().removeObserver(self)
  }

  func receiveNotification(_ notification: Notification) {
    switch notification.name {
    case NSNotification.Name.MaBeeeDeviceRssiDidUpdate:
      if let identifier = notification.userInfo?["MaBeeeDeviceIdentifier"] as? UInt,
        let device = MaBeeeApp.instance().device(withIdentifier: identifier) {
          appendLine(device.name + " RSSI : " + String(device.rssi))
        }
    case NSNotification.Name.MaBeeeDeviceBatteryVoltageDidUpdate:
      if let identifier = notification.userInfo?["MaBeeeDeviceIdentifier"] as? UInt,
        let device = MaBeeeApp.instance().device(withIdentifier: identifier) {
        appendLine(device.name + " Volgate : " + String(device.batteryVoltage))
      }
    default:
      print(notification.name)
    }
  }

  func appendLine(_ line: String) {
    textView.text = textView.text + line + "\n"
  }

  @IBAction func scanButtnPressed(_ sender: UIButton) {
    let vc = MaBeeeScanViewController()
    vc.show(self)
  }

  @IBAction func updateButtonPressed(_ sender: UIButton) {
    for device in MaBeeeApp.instance().devices() {
      device.updateRssi()
      device.updateBatteryVoltage()
    }
  }
}


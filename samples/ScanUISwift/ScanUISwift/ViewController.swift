//
//  ViewController.swift
//  ScanUISwift
//
//  Created by Takeshi Shoji on 8/22/16.
//  Copyright © 2016 Novars Inc. All rights reserved.
//

import UIKit
import MaBeeeSDK

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func sliderValueChanged(_ sender: UISlider) {
    for device in MaBeeeApp.instance().devices() {
      device.pwmDuty = Int32(sender.value * 100)
    }
  }
}


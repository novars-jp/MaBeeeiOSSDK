//
//  ViewController.swift
//  FirstMaBeeeSwift
//
//  Created by Takeshi Shoji on 2016/08/16.
//  Copyright © 2016年 Novars Inc. All rights reserved.
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


  @IBAction func scanButtonPressed(sender: UIButton) {
    let vc = MaBeeeScanViewController()
    vc.show(self)
  }

  @IBAction func sliderValueChanged(slider: UISlider) {
    for device in MaBeeeApp.instance().devices() {
      device.pwmDuty = Int32(slider.value * 100)
    }
  }
}


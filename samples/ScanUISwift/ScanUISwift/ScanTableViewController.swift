//
//  ScanTableViewController.swift
//  ScanUISwift
//
//  Created by Takeshi Shoji on 8/22/16.
//  Copyright © 2016 Novars Inc. All rights reserved.
//

import UIKit
import MaBeeeSDK

class ScanTableViewController: UITableViewController {

  var maBeeeDevices:[MaBeeeDevice]?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done,
                                                            target: self,
                                                            action: #selector(doneButtonPressed))
  }

  func doneButtonPressed() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().addObserver(self, selector: #selector(receiveNotification(_:)))
    MaBeeeApp.instance().startScan({(devices: [MaBeeeDevice]!) in
      print(devices)
      self.maBeeeDevices = devices
      self.tableView.reloadData()
    })
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().removeObserver(self)
    MaBeeeApp.instance().stopScan()
  }

  func receiveNotification(notification: NSNotification) {
    self.tableView.reloadData()
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let devices = maBeeeDevices {
      return devices.count;
    }
    return 0;
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MaBeeeDeviceCell", forIndexPath: indexPath)
    if let device = maBeeeDevices?[indexPath.row] {
      cell.textLabel?.text = String(format: "%@, %d, %@",
                                    device.name,
                                    device.rssi,
                                    self.stateString(device.state))
    }
    return cell;
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    if let device = maBeeeDevices?[indexPath.row] {
      switch (device.state) {
      case .Disconnected:
        MaBeeeApp.instance().connect(device)
      case .Connecting:
        MaBeeeApp.instance().disconnect(device)
      case .Connected:
        MaBeeeApp.instance().disconnect(device)
      }
    }
  }


  func stateString(state: MaBeeeDeviceState) -> String {
    var stateString: String
    switch (state) {
    case .Disconnected:
      stateString = "Disconnected"
    case .Connecting:
      stateString = "Connecting"
    case .Connected:
      stateString = "Connected"
    }
    return stateString
  }
}

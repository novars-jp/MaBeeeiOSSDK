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
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonPressed))
  }

  func doneButtonPressed() {
    self.dismiss(animated: true, completion: nil)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().addObserver(self, selector: #selector(receiveNotification(_:)))
    MaBeeeApp.instance().startScan({(devices: [MaBeeeDevice]?) in
      print(devices ?? "nil")
      self.maBeeeDevices = devices
      self.tableView.reloadData()
    })
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidAppear(animated)
    MaBeeeApp.instance().removeObserver(self)
    MaBeeeApp.instance().stopScan()
  }

  func receiveNotification(_ notification: Notification) {
    self.tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let devices = maBeeeDevices {
      return devices.count;
    }
    return 0;
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MaBeeeDeviceCell", for: indexPath)
    if let device = maBeeeDevices?[indexPath.row] {
      cell.textLabel?.text = String(format: "%@, %d, %@",
                                    device.name,
                                    device.rssi,
                                    self.stateString(device.state))
    }
    return cell;
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let device = maBeeeDevices?[indexPath.row] {
      switch (device.state) {
      case .disconnected:
        MaBeeeApp.instance().connect(device)
      case .connecting:
        MaBeeeApp.instance().disconnect(device)
      case .connected:
        MaBeeeApp.instance().disconnect(device)
      }
    }
  }


  func stateString(_ state: MaBeeeDeviceState) -> String {
    var stateString: String
    switch (state) {
    case .disconnected:
      stateString = "Disconnected"
    case .connecting:
      stateString = "Connecting"
    case .connected:
      stateString = "Connected"
    }
    return stateString
  }
}

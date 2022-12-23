//
//  BLEManager.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    var myCentral: CBCentralManager!
    @Published var bluetoothOn = false
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            bluetoothOn = true
        } else {
            bluetoothOn = false
        }
    }
}

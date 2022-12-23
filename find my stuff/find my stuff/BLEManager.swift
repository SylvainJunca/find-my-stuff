//
//  BLEManager.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import Foundation
import CoreBluetooth

struct Device: Identifiable {
    let id: Int
    let name: String!
    var rssi: NSNumber
    let info: [String: Any]
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    var myCentral: CBCentralManager!
    
    @Published var bluetoothOn = false
    @Published var devices = [Device]()
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
        if central.state == .poweredOn {
            bluetoothOn = true
        } else {
            bluetoothOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var deviceName : String!
        if let name = peripheral.name {
            deviceName = name
        } else {
            deviceName = "Unknown"
        }
        
//        if(devices.firstIndex(where: { Device in
//            if Device.name == deviceName {
//
//            }
//        }))
        let newDevice = Device(id: devices.count, name:deviceName, rssi: RSSI, info: advertisementData)
        devices.append(newDevice)
        
    }
    
    func startScanning(){
        myCentral.scanForPeripherals(withServices: nil, options: nil)
    }
    func stopScanning() {
        myCentral.stopScan()
    }
}

//
//  BLEManager.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import Foundation
import CoreBluetooth

struct Device: Identifiable {
    let id: NSUUID
    let name: String!
    var rssi: NSNumber
    var timestamp : Date
    let peripheral: CBPeripheral
    let info: [String: Any]
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    var myCentral: CBCentralManager!
    
    @Published var bluetoothOn = false
    @Published var devices = [Device]()
    @Published var isScanning = false
    
    static let purgeTime:Double = 30.0
    
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
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var deviceName : String!
        let id = peripheral.identifier
        if let name = peripheral.name {
            deviceName = name
        } else {
            deviceName = "Unknown"
        }
        
        if let index = (devices.firstIndex(where: { $0.id as UUID == id })) {
            var refreshDevice = devices[index]
            refreshDevice.rssi = RSSI
            refreshDevice.timestamp = Date()
        } else {
            let newDevice = Device(id: id as NSUUID, name:deviceName, rssi: RSSI, timestamp: Date(), peripheral: peripheral, info: advertisementData)
            devices.append(newDevice)
        }
        
        devices = devices.filter({Date().timeIntervalSince($0.timestamp) < BLEManager.purgeTime }).sorted(by: { device1, device2 in
            return device1.rssi as! Double > device2.rssi as! Double
        })
    }
    
    func startScanning(){
        myCentral.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        isScanning = myCentral.isScanning
    }
    func stopScanning() {
        myCentral.stopScan()
        isScanning = myCentral.isScanning
    }
}

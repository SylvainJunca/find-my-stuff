//
//  ContentView.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var bleManager = BLEManager()
    var body: some View {
        NavigationView {
            VStack (spacing: 10) {
                if !bleManager.bluetoothOn {
                    Text("You need to turn the bluetooth on")
                        .foregroundColor(.red)
                }
                if bleManager.isScanning {
                    Text("Scanning...")
                        .foregroundColor(.blue)
                        .animation(.spring(blendDuration: 0))
                }
                Spacer()
                
                List(bleManager.devices, id: \.id) { device in
                    NavigationLink(destination: DeviceDetailsView(device: device)) {
                        HStack {
                            Text(device.name)
                            Text(String(describing: device.rssi))
                        }
                    }
                }.frame(height: 600)
                Spacer()
                HStack (spacing: 10) {
                    Button(action: {
                        self.bleManager.startScanning()
                    }) {
                        Text("Start Scanning").font(.headline)
                    }.tint(.green)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape (.capsule)
                        .controlSize (.large)
                    Button(action: {
                        self.bleManager.stopScanning()
                    }) {
                        Text("Stop Scanning").font(.headline)
                    }.tint(.red)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape (.capsule)
                        .controlSize (.large)
                }.buttonStyle(.bordered)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

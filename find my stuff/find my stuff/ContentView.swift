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
            VStack (spacing: 10) {
                if !bleManager.bluetoothOn {
                    Text("You need to turn the bluetooth on")
                        .foregroundColor(.red)
                }
                List(bleManager.devices) { device in
                    HStack {
                        Text(device.name)
                        Text(String(describing: device.rssi))
                    }
                }.frame(height: 600)
              
                
                Spacer()
                HStack (spacing: 10) {
                    Button(action: {
                        self.bleManager.startScanning()
                    }) {
                        Text("Start Scanning")
                    }
                    Button(action: {
                        print("Stop Scanning")
                    }) {
                        Text("Stop Scanning")
                    }
                }.padding()
                Spacer()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

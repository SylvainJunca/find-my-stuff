//
//  DeviceDetailsView.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-23.
//

import SwiftUI

struct DeviceDetailsView: View {
    
    let device : Device
    
    var body: some View {
        VStack {
            Text(device.name)
            Text(device.timestamp, style: .relative)
            Text(String(describing: device.rssi))
//            List {
//                ForEach(device.advertisementData) { advertisement in
//                    Text(String(describing: advertisement))
//                                    }
//            }
            
           
        }.navigationBarTitle(Text (device.name), displayMode: .inline)

    }
}

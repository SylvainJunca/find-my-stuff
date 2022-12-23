//
//  ContentView.swift
//  find my stuff
//
//  Created by Sylvain Junca on 2022-12-22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
            VStack (spacing: 10) {
                Text("Bluetooth around")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                List() {
                    Text("placeholder 1")
                    Text("placeholder 2")
                }.frame(height: 300)
                Spacer()
                Text("STATUS")
                    .font(.headline)
                // Status goes here
                Text("Bluetooth status here")
                    .foregroundColor(.red)
                Spacer()
                HStack {
                    VStack (spacing: 10) {
                        Button(action: {
                            print("Start Scanning")
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
                    VStack (spacing: 10) {
                        Button(action: {
                            print("Start Advertising")
                        }) {
                            Text("Start Advertising")
                        }
                        Button(action: {
                            print("Stop Advertising")
                        }) {
                            Text("Stop Advertising")
                        }
                    }.padding()
                }
                Spacer()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

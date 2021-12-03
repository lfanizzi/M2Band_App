//
//  ViewController.swift
//  M2Band
//
//  Created by Luke Fanizzi on 11/30/21.
//

import Foundation
import CoreBluetooth
import UIKit
   import CoreBluetooth

   class ParticlePeripheral: NSObject {

       /// MARK: - Particle LED services and charcteristics Identifiers

       public static let particleLEDServiceUUID     = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6")
       public static let redLEDCharacteristicUUID   = CBUUID.init(string: "b4250401-fb4b-4746-b2b0-93f0e61122c6")
       public static let greenLEDCharacteristicUUID = CBUUID.init(string: "b4250402-fb4b-4746-b2b0-93f0e61122c6")
       public static let blueLEDCharacteristicUUID  = CBUUID.init(string: "b4250403-fb4b-4746-b2b0-93f0e61122c6")

   }
class ViewController: UIViewController, CBPeripheralDelegate, CBCentralManagerDelegate {
    // Properties
        private var centralManager: CBCentralManager!
        private var peripheral: CBPeripheral!
    
    // If we're powered on, start scanning
            func centralManagerDidUpdateState(_ central: CBCentralManager) {
                print("Central state update")
                if central.state != .poweredOn {
                    print("Central is not powered on")
                } else {
                    print("Central scanning for", ParticlePeripheral.particleLEDServiceUUID);
                    centralManager.scanForPeripherals(withServices: [ParticlePeripheral.particleLEDServiceUUID],
                                                      options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
                }
    
    
}
    // Handles the result of the scan
            func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

                // We've found it so stop scan
                self.centralManager.stopScan()

                // Copy the peripheral instance
                self.peripheral = peripheral
                self.peripheral.delegate = self

                // Connect!
                self.centralManager.connect(self.peripheral, options: nil)

            }
    
    // The handler if we do connect succesfully
            func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
                if peripheral == self.peripheral {
                    print("Connected to your Particle Board")
                    peripheral.discoverServices([ParticlePeripheral.particleLEDServiceUUID])
                }
            }
    
    
    // Handles discovery event
            func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
                if let services = peripheral.services {
                    for service in services {
                        if service.uuid == ParticlePeripheral.particleLEDServiceUUID {
                            print("LED service found")
                            //Now kick off discovery of characteristics
                            peripheral.discoverCharacteristics([ParticlePeripheral.redLEDCharacteristicUUID,
                                                                     ParticlePeripheral.greenLEDCharacteristicUUID,
                                                                     ParticlePeripheral.blueLEDCharacteristicUUID], for: service)
                            return
                        }
                    }
                }
            }
    
    // Handling discovery of characteristics
            func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
                if let characteristics = service.characteristics {
                    for characteristic in characteristics {
                        if characteristic.uuid == ParticlePeripheral.redLEDCharacteristicUUID {
                            print("Red LED characteristic found")
                        } else if characteristic.uuid == ParticlePeripheral.greenLEDCharacteristicUUID {
                            print("Green LED characteristic found")
                        } else if characteristic.uuid == ParticlePeripheral.blueLEDCharacteristicUUID {
                            print("Blue LED characteristic found");
                        }
                    }
                }
            }

        }

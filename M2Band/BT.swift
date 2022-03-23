//
//  BT.swift
//  M2Band
//
//  Created by Luke Fanizzi on 12/2/21.
//

import Foundation
import CoreBluetooth

class CoreBluetoothManager: NSObject, BluetoothManager, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    
    // MARK: - Public properties
    weak var delegate: BluetoothManagerDelegate?
    private(set) var peripherals = Dictionary<UUID, CBPeripheral>() {
        didSet {
            delegate?.peripheralsDidUpdate()
        }
    }

    // MARK: - Public methods
    func startAdvertising(with name: String) {
        self.name = name
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    // MARK: - Private properties
    private var peripheralManager: CBPeripheralManager?
    private var centralManager: CBCentralManager?
    private var name: String?
}


protocol BluetoothManagerDelegate: AnyObject {
    func peripheralsDidUpdate()
}

protocol BluetoothManager {
    var peripherals: Dictionary<UUID, CBPeripheral> { get }
    var delegate: BluetoothManagerDelegate? { get set }
    func startAdvertising(with name: String)
    func startScanning()
}
extension CoreBluetoothManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            if peripheral.isAdvertising {
                peripheral.stopAdvertising()
            }

            let uuid = CBUUID(string: Constants.SERVICE_UUID.rawValue)
            var advertisingData: [String : Any] = [
                CBAdvertisementDataServiceUUIDsKey: [uuid]
            ]

            if let name = self.name {
                advertisingData[CBAdvertisementDataLocalNameKey] = name
            }
            self.peripheralManager?.startAdvertising(advertisingData)
        } else {
            #warning("handle other states")
        }
    }
}

enum Constants: String {
    case SERVICE_UUID = "4DF91029-B356-463E-9F48-BAB077BF3EF5"
}



/*Extra CODE
 
 /*
 internal func centralManagerDidUpdateState(_ central: CBCentralManager) {

     switch central.state {
     case .poweredOn:
         // ... so start working with the peripheral
         os_log("CBManager is powered on")
             retrievePeripheral()
     case .poweredOff:
         os_log("CBManager is not powered on")
         // In a real app, you'd deal with all the states accordingly
         return
     case .resetting:
         os_log("CBManager is resetting")
         // In a real app, you'd deal with all the states accordingly
         return
     case .unauthorized:
         // In a real app, you'd deal with all the states accordingly
         if #available(iOS 13.0, *) {
             switch central.authorization {
             case .denied:
                 os_log("You are not authorized to use Bluetooth")
             case .restricted:
                 os_log("Bluetooth is restricted")
             default:
                 os_log("Unexpected authorization")
             }
         } else {
             // Fallback on earlier versions
         }
         return
     case .unknown:
         os_log("CBManager state is unknown")
         // In a real app, you'd deal with all the states accordingly
         return
     case .unsupported:
         os_log("Bluetooth is not supported on this device")
         // In a real app, you'd deal with all the states accordingly
         return
     @unknown default:
         os_log("A previously unknown central manager state occurred")
         // In a real app, you'd deal with yet unknown cases that might occur in the future
         return
     }
 }


 /*
  *  This callback comes whenever a peripheral that is advertising the transfer serviceUUID is discovered.
  *  We check the RSSI, to make sure it's close enough that we're interested in it, and if it is,
  *  we start the connection process
  */
 func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                     advertisementData: [String: Any], rssi RSSI: NSNumber) {
     
     // Reject if the signal strength is too low to attempt data transfer.
     // Change the minimum RSSI value depending on your app’s use case.
     guard RSSI.intValue >= -50
         else {
             os_log("Discovered perhiperal not in expected range, at %d", RSSI.intValue)
             return
     }
     
     os_log("Discovered %s at %d", String(describing: peripheral.name), RSSI.intValue)
     
     // Device is in range - have we already seen it?
     if discoveredPeripheral != peripheral {
         
         // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it.
         discoveredPeripheral = peripheral
         
         // And finally, connect to the peripheral.
         os_log("Connecting to perhiperal %@", peripheral)
         centralManager.connect(peripheral, options: nil)
     }
 }

 /*
  *  If the connection fails for whatever reason, we need to deal with it.
  */
 func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
     os_log("Failed to connect to %@. %s", peripheral, String(describing: error))
     cleanup()
 }

 /*
  *  We've connected to the peripheral, now we need to discover the services and characteristics to find the 'transfer' characteristic.
  */
 func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
     os_log("Peripheral Connected")
     
     // Stop scanning
     centralManager.stopScan()
     os_log("Scanning stopped")
     
     // set iteration info
     connectionIterationsComplete += 1
     writeIterationsComplete = 0
     
     // Clear the data that we may already have
     data.removeAll(keepingCapacity: false)
     
     // Make sure we get the discovery callbacks
     peripheral.delegate = self
     
     // Search only for services that match our UUID
     peripheral.discoverServices([TransferService.serviceUUID])
 }

 /*
  *  Once the disconnection happens, we need to clean up our local copy of the peripheral
  */
 func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
     os_log("Perhiperal Disconnected")
     discoveredPeripheral = nil
     
     // We're disconnected, so start scanning again
     if connectionIterationsComplete < defaultIterations {
         retrievePeripheral()
     } else {
         os_log("Connection iterations completed")
     }
 }

 }

 extension CentralViewController: CBPeripheralDelegate {
 // implementations of the CBPeripheralDelegate methods

 /*
  *  The peripheral letting us know when services have been invalidated.
  */
 func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
     
     for service in invalidatedServices where service.uuid == TransferService.serviceUUID {
         os_log("Transfer service is invalidated - rediscover services")
         peripheral.discoverServices([TransferService.serviceUUID])
     }
 }

 /*
  *  The Transfer Service was discovered
  */
 func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
     if let error = error {
         os_log("Error discovering services: %s", error.localizedDescription)
         cleanup()
         return
     }
     
     // Discover the characteristic we want...
     
     // Loop through the newly filled peripheral.services array, just in case there's more than one.
     guard let peripheralServices = peripheral.services else { return }
     for service in peripheralServices {
         peripheral.discoverCharacteristics([TransferService.characteristicUUID], for: service)
     }
 }

 /*
  *  The Transfer characteristic was discovered.
  *  Once this has been found, we want to subscribe to it, which lets the peripheral know we want the data it contains
  */
 func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
     // Deal with errors (if any).
     if let error = error {
         os_log("Error discovering characteristics: %s", error.localizedDescription)
         cleanup()
         return
     }
     
     // Again, we loop through the array, just in case and check if it's the right one
     guard let serviceCharacteristics = service.characteristics else { return }
     for characteristic in serviceCharacteristics where characteristic.uuid == TransferService.characteristicUUID {
         // If it is, subscribe to it
         transferCharacteristic = characteristic
         peripheral.setNotifyValue(true, for: characteristic)
     }
     
     // Once this is complete, we just need to wait for the data to come in.
 }

 /*
  *   This callback lets us know more data has arrived via notification on the characteristic
  */
 func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
     // Deal with errors (if any)
     if let error = error {
         os_log("Error discovering characteristics: %s", error.localizedDescription)
         cleanup()
         return
     }
     
     guard let characteristicData = characteristic.value,
         let stringFromData = String(data: characteristicData, encoding: .utf8) else { return }
     
     os_log("Received %d bytes: %s", characteristicData.count, stringFromData)
     
     // Have we received the end-of-message token?
     if stringFromData == "EOM" {
         // End-of-message case: show the data.
         // Dispatch the text view update to the main queue for updating the UI, because
         // we don't know which thread this method will be called back on.
         DispatchQueue.main.async() {
             self.textView.text = String(data: self.data, encoding: .utf8)
         }
         
         // Write test data
         writeData()
     } else {
         // Otherwise, just append the data to what we have previously received.
         data.append(characteristicData)
     }
 }

 /*
  *  The peripheral letting us know whether our subscribe/unsubscribe happened or not
  */
 func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
     // Deal with errors (if any)
     if let error = error {
         os_log("Error changing notification state: %s", error.localizedDescription)
         return
     }
     
     // Exit if it's not the transfer characteristic
     guard characteristic.uuid == TransferService.characteristicUUID else { return }
     
     if characteristic.isNotifying {
         // Notification has started
         os_log("Notification began on %@", characteristic)
     } else {
         // Notification has stopped, so disconnect from the peripheral
         os_log("Notification stopped on %@. Disconnecting", characteristic)
         cleanup()
     }
     
 }

 /*
  *  This is called when peripheral is ready to accept more data when using write without response
  */
 func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
     os_log("Peripheral is ready, send data")
     writeData()
 }

 }
  */


 
 
 */

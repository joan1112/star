//
//  CoinTranstion.swift
//  AllStars
//
//  Created by Mac on 2021/12/13.
//
import Foundation
import BigInt
import SwiftUI
import web3swift

public class coinTranstion:NSObject
{
    @objc var jsonDic: Dictionary < String, String > = [:]
    @objc func getTokenMinerFee()->String{
        let  web3 = try! Web3.new(URL(string: rpcURL)!)
        
        let dict1: Dictionary < String, String > = jsonDic
//        let values = Web3.Utils.hexToBigUInt(dict1["value"]!)!
        let tokenAddress = EthereumAddress(dict1["token"]!)!
        let fromAddress = EthereumAddress(dict1["from"]!)!
        let toAddress = EthereumAddress(dict1["to"]!)
//-0.00041209
        let mnemonic = UserDefaults.standard.value(forKey: "mnemonics")
        let password = UserDefaults.standard.value(forKey: "pass")as!String
        let privateKey = UserDefaults.standard.value(forKey: "privateKey")as!String
        var options = TransactionOptions()
        options.callOnBlock = .pending // or .latest / or .exactBlockNumber(BigUInt)
        options.nonce = .pending // or .latest / or .manual(BigUInt)
        options.gasLimit = .automatic // or .manual(BigUInt) / or .limited(BigUInt) / or .withMargin(Double)manual(BigUInt(4_300_000))
        options.gasPrice = .automatic // or .manual(BigUInt) / or .withMargin(Double)//.manual(BigUInt(22_000_000_000))
        options.to = toAddress
        options.from = fromAddress
        options.value = 0;
      
        let amount = Web3.Utils.parseToBigUInt(dict1["value"]!, units: .eth)
        if let mem = mnemonic,(mem as! String).isEmpty {
            let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
            let dataKey = Data.fromHex(formattedKey)!
            let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
        }else{
            let keystore = try! BIP32Keystore(
                            mnemonics: mnemonic as! String,
                            password: password,
                            mnemonicsPassword: "",
                            language: .english)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
            
        }
                    let contract = web3.contract(Web3.Utils.erc20ABI, at: tokenAddress, abiVersion: 2)
        
           let parameters = [toAddress as Any, amount as Any] as [AnyObject]
                    let tx = contract?.write(
                    "transfer",parameters: parameters,
                    extraData: Data(),
                    transactionOptions: options)
                    tx?.transactionOptions.from = fromAddress
                    tx?.transactionOptions.value = amount
        if(options.to==nil){
            return "error:Please enter the correct address"
        }

        do{
            let limtS = try web3.eth.estimateGas(tx!.transaction, transactionOptions: options)
               let limtPrice =  try! web3.eth.getGasPrice()
            let total = limtS * limtPrice
            let totalS = Web3.Utils.formatToEthereumUnits(total, toUnits: .eth, decimals: 8)!
            return totalS;
        }catch{
            let errors:Web3Error = error as! Web3Error
            return errors.errorDescription
        }
    }
    @objc func getMinerFee()->String{
        let  web3 = try! Web3.new(URL(string: rpcURL)!)
        let dict1: Dictionary < String, String > = jsonDic
        let amount = Web3.Utils.parseToBigUInt(dict1["value"]!, units: .eth)
        let fromAddress = EthereumAddress(dict1["from"]!)!
        let toAddress = EthereumAddress(dict1["to"]!)!
       
        var options = TransactionOptions()
        options.callOnBlock = .pending // or .latest / or .exactBlockNumber(BigUInt)
        options.nonce = .pending // or .latest / or .manual(BigUInt)
        options.gasLimit = .automatic // or .manual(BigUInt) / or .limited(BigUInt) / or .withMargin(Double)manual(BigUInt(4_300_000))
        options.gasPrice = .automatic // or .manual(BigUInt) / or .withMargin(Double)//.manual(BigUInt(22_000_000_000))
        options.to = toAddress
        options.from = fromAddress
        
        let transaction = EthereumTransaction.init(gasPrice: BigUInt(0), gasLimit:  BigUInt(0), to: toAddress, value: amount!, data: Data())
        do{
            let limtS = try web3.eth.estimateGas(transaction, transactionOptions: options)
               let limtPrice =  try! web3.eth.getGasPrice()
            let total = limtS * limtPrice
            let totalS = Web3.Utils.formatToEthereumUnits(total, toUnits: .eth, decimals: 8)!
            return totalS;
        }catch{
            let errors:Web3Error = error as! Web3Error
            print(errors.errorDescription);
            return errors.errorDescription
        }
       
    }
    @objc func transferBnb()->String{
        //
        
        let  web3 = try! Web3.new(URL(string: rpcURL)!)
        let dict1: Dictionary < String, String > = jsonDic
//        let values = Web3.Utils.hexToBigUInt(dict1["value"]!)!
//        let tokenAddress = EthereumAddress(dict1["token"]!)
        let fromAddress = EthereumAddress(dict1["from"]!)!
        let toAddress = EthereumAddress(dict1["to"]!)!


        var options = TransactionOptions()
        options.callOnBlock = .pending // or .latest / or .exactBlockNumber(BigUInt)
        options.nonce = .pending // or .latest / or .manual(BigUInt)
        options.gasLimit = .automatic // or .manual(BigUInt) / or .limited(BigUInt) / or .withMargin(Double)manual(BigUInt(4_300_000))
        options.gasPrice = .automatic // or .manual(BigUInt) / or .withMargin(Double)//.manual(BigUInt(22_000_000_000))
        options.to = toAddress
        options.from = fromAddress
        
        
      
        let mnemonic = UserDefaults.standard.value(forKey: "mnemonics")as!String
        let password = UserDefaults.standard.value(forKey: "pass")as!String
        let privateKey = UserDefaults.standard.value(forKey: "privateKey")as!String
        
        let amount = Web3.Utils.parseToBigUInt(dict1["value"]!, units: .eth)
        options.value = amount;


        if mnemonic .isEmpty {
            let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
            let dataKey = Data.fromHex(formattedKey)!
            let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
    
        
        }else{

            let keystore = try! BIP32Keystore(
                mnemonics: mnemonic ,
                            password: password,
                            mnemonicsPassword: "",
                            language: .english)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
        }
        let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)
        let writeTX = contract!.write("fallback")
        writeTX!.transactionOptions.from = fromAddress
        writeTX!.transactionOptions.value = amount
 
      
        
        
        do {
            let result = try writeTX!.send(password: password, transactionOptions: options)
            print(result)
            return "success"
            
        }catch{
            print("Error trying to call method \(error)")

            return "error"
        }
    }
       


    @objc func transfer()->String
    {
//        let  web3 = try! Web3.new(URL(string: rpcURL)!)
//
//        let dict1: Dictionary < String, String > = jsonDic
////        //dict1["value"]!
//       let values = Web3.Utils.parseToBigUInt(dict1["value"]!, units: .eth)
////        let values = Web3.Utils.parseToBigUInt(dict1["value"]!, decimals: decimal)!
//
//        let tokenAddress = EthereumAddress(dict1["token"]!)!
//        let fromAddress = EthereumAddress(dict1["from"]!)!
//        let toAddress = EthereumAddress(dict1["to"]!)!
//
//        let options = TransactionOptions.fromJSON(jsonDic)!
//        var transactionOptions = TransactionOptions()
//        transactionOptions.from = options.from
//        transactionOptions.to = options.to
////        transactionOptions.value = options.value != nil ? options.value! : BigUInt(0)
////        transactionOptions.value = values
////        transactionOptions.gasLimit = .manual(Web3.Utils.hexToBigUInt("0x419ce0")!)
////        transactionOptions.gasPrice = .manual(Web3.Utils.hexToBigUInt("0x51f4d5c00")!)
//        transactionOptions.gasLimit = .automatic
//        transactionOptions.gasPrice = .automatic
//        transactionOptions.callOnBlock = .latest
//
////        let nonceS = try! web3.eth.getTransactionCount(address: fromAddress)
////        transactionOptions.nonce = .manual(nonceS)
//        transactionOptions.nonce = .pending
        //1 通过助记词生成keyStore   2 通过私钥生成keystore
        let mnemonic = UserDefaults.standard.value(forKey: "mnemonics")
        let password = UserDefaults.standard.value(forKey: "pass")as!String
        let privateKey = UserDefaults.standard.value(forKey: "privateKey")as!String
        let  web3 = try! Web3.new(URL(string: rpcURL)!)
        let dict1: Dictionary < String, String > = jsonDic
//        let values = Web3.Utils.hexToBigUInt(dict1["value"]!)!
        let tokenAddress = EthereumAddress(dict1["token"]!)!
        let fromAddress = EthereumAddress(dict1["from"]!)!
        let toAddress = EthereumAddress(dict1["to"]!)!


        var options = TransactionOptions()
        options.callOnBlock = .pending // or .latest / or .exactBlockNumber(BigUInt)
        options.nonce = .pending // or .latest / or .manual(BigUInt)
        options.gasLimit = .automatic // or .manual(BigUInt) / or .limited(BigUInt) / or .withMargin(Double)manual(BigUInt(4_300_000))
        options.gasPrice = .automatic // or .manual(BigUInt) / or .withMargin(Double)//.manual(BigUInt(22_000_000_000))
        options.to = toAddress
        options.from = fromAddress
        options.value = 0;
      
        let amount = Web3.Utils.parseToBigUInt(dict1["value"]!, units: .eth)
        if let mem = mnemonic,(mem as! String).isEmpty {
            let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
            let dataKey = Data.fromHex(formattedKey)!
            let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
        }else{
            let keystore = try! BIP32Keystore(
                            mnemonics: mnemonic as! String,
                            password: password,
                            mnemonicsPassword: "",
                            language: .english)!
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager)
            
        }
                    let contract = web3.contract(Web3.Utils.erc20ABI, at: tokenAddress, abiVersion: 2)
                    let parameters = [toAddress, amount as Any] as [AnyObject]
                    let tx = contract?.write(
                    "transfer",parameters: parameters,
                    extraData: Data(),
                    transactionOptions: options)
                    tx?.transactionOptions.from = fromAddress
                    tx?.transactionOptions.value = amount
                    do {
                        let result = try tx!.send(password: password, transactionOptions: options)
                        print(result)
                        return "success"
                        
                    }catch{
                        print("Error trying to call method \(error)")

                        return "error"
                    }
   
       
       
    }
    
    // 补齐64位，不够前面用0补齐
    func addPreZero(num:String)->String{
      let t = num.count
      var s:String = ""
      for _ in 0 ..< 64-t{
          s = s + "0";
      }
      return s+num;
    }

    @objc func getStlTokenBalance()->String{
   
        guard let web3 = try? Web3.new(URL(string: rpcURL)!) else {
            return "00";
        }
        let dict1: Dictionary < String, String > = jsonDic
        let tokenAddress = EthereumAddress(dict1["stlToken"]!)!
        let fromAddress = EthereumAddress(dict1["from"]!)!
        var transactionOptions = TransactionOptions()
        transactionOptions.from = fromAddress
        transactionOptions.value = 0
        transactionOptions.gasLimit = .automatic
        transactionOptions.gasPrice = .automatic
        guard let nonceS = try? web3.eth.getTransactionCount(address: fromAddress)else{
            return "error";
        }
        transactionOptions.nonce = .manual(nonceS)
        transactionOptions.callOnBlock = .latest
        
        let contractABI = Web3Utils.st20ABI // Contract ABI
        let abiVersion = 2 // Contract ABI version
        let extraData: Data = Data() // Extra data for contract method
        let contract = web3.contract(contractABI, at: tokenAddress, abiVersion: abiVersion)!
        
        let tx = contract.read(
            "balanceOf",
            parameters: [fromAddress] as [AnyObject],
            extraData: extraData,
            transactionOptions: transactionOptions)
        guard  let results = try? tx?.call(transactionOptions: transactionOptions)else{
            return "0"
        }
        let str = results?["0"] as! BigUInt
        let newStr = Web3.Utils.formatToEthereumUnits(str, toUnits: .eth, decimals: 2)!
        return newStr
    }
    @objc func getTokenBalance()->String{
        guard let web3 = try? Web3.new(URL(string: rpcURL)!) else {
            return "00";
        }
        let dict1: Dictionary < String, String > = jsonDic
//        let values = Web3.Utils.hexToBigUInt(dict1["value"]!)!
        let tokenAddress = EthereumAddress(dict1["token"]!)!
        let fromAddress = EthereumAddress(dict1["from"]!)!
//        let toAddress = EthereumAddress(dict1["to"]!)!
        
        var transactionOptions = TransactionOptions()
        transactionOptions.from = fromAddress
//        transactionOptions.to = toAddress
        transactionOptions.value = 0
        transactionOptions.gasLimit = .automatic
        transactionOptions.gasPrice = .automatic
        let nonceS = try! web3.eth.getTransactionCount(address: fromAddress)
        transactionOptions.nonce = .manual(nonceS)
        transactionOptions.callOnBlock = .latest
        
        let contractABI = Web3Utils.st20ABI // Contract ABI
        let abiVersion = 2 // Contract ABI version
        let extraData: Data = Data() // Extra data for contract method
        let contract = web3.contract(contractABI, at: tokenAddress, abiVersion: abiVersion)!
        
        let tx = contract.read(
            "balanceOf",
            parameters: [fromAddress] as [AnyObject],
            extraData: extraData,
            transactionOptions: transactionOptions)
        let results = try! tx?.call(transactionOptions: transactionOptions)
        let str = results?["0"] as! BigUInt
        let newStr = Web3.Utils.formatToEthereumUnits(str, toUnits: .eth, decimals: 2)!
        return newStr
    }
    
    @objc func getBalance()->String{
        let dict1: Dictionary < String, String > = jsonDic
        guard let web3 = try? Web3.new(URL(string: rpcURL)!) else {
            return "00";
        }
        let walletAddress = EthereumAddress(dict1["from"]!)! // Address which balance we want to know
        //获取余额
        let balanceResult = try? web3.eth.getBalance(address: walletAddress)
        let balanceStr = Web3.Utils.formatToEthereumUnits(balanceResult ?? BigUInt(0), toUnits: .eth, decimals: 2)!
        return balanceStr
    }
}

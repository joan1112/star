// Copyright © 2017-2020 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WebKit

struct WKUserScriptConfig {

    let address: String
    let chainId: Int
    let rpcUrl: String

    var providerJsBundleUrl: URL {
        let bundlePath = Bundle.main.path(forResource: "TrustWeb3Provider", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)!
        return bundle.url(forResource: "trust-min", withExtension: "js")!
    }

    var providerJsUrl: URL {
        return Bundle.main.url(forResource: "trust-min", withExtension: "js")!
    }

    var providerScript: WKUserScript {
        let source = try! String(contentsOf: providerJsUrl)
        let script = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        return script
    }

    var injectedScript: WKUserScript {
        let source =
        """
        (function() {
            var config = {
                chainId: \(chainId),
                rpcUrl: "\(rpcUrl)",
                isDebug: true
            };
            window.ethereum = new trustwallet.Provider(config);
            window.web3 = new trustwallet.Web3(window.ethereum);
            trustwallet.postMessage = (jsonString) => {
                webkit.messageHandlers._tw_.postMessage(jsonString)
            };
        })();
        """

        let script = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        return script
    }
}

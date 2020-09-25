# AndChargeAccountLink

## What is this repository for? ##

* This sdk is meant to simplify the integration of account linking with &Charge on iOS
* Version 1.0.1

## Installation

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate GoodieCore into your Xcode project using CocoaPods, specify it in your Podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AndChargeAccountLink', '~> 1.0'
end
```

Then, run the following command:

```
$ pod install
```

## How to set up: ##

```
import AndChargeAccountLink
```

#### 1) Include QueriesSchemes in your Info.plist
```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>andcharge</string>
</array>
```
#### 2) Hanldle callback from &Charge. Add in your AppDelegate.swift 
```
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
  ///......
  ACAccountLink.shared.accountLinkCallBack(url: url)
  ///......
}
```
#### OR 

#### 2) Hanldle callback from &Charge. Add in your SceneDelegate.swift
```
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let callBackUrl = URLContexts.first?.url{
        ACAccountLink.shared.accountLinkCallBack(url: callBackUrl)
    }
}
```

## Example: ##
### 1) Below is sample code which you can call link accounnt to &Charge
```
 ...
 ...
        ACAccountLink.shared.delegate = self
        ACAccountLink.shared.linkAccount(partnerId: "partnerId001",
                                         partnerUserId: "partnerUserId001",
                                         activationCode: "activationCodeTest",
                                         callbackUrl: "coolmobilityprovider://and-charge/link") 
                                         //callbackUrl is your URLSchema
 ...
 ...
```
### 2) Below is sample code to handle delegate
```
extension ViewController: ACAccountLinkDelegate {
    
    func didRequestAccountLink(with requestUrl: URL?, error: ACAccountLinkError?) {
        if let requestUrl = requestUrl{
            print(requestUrl.absoluteString)
        }
        if let error = error{
            // return Error
            print(error.localizedDescription)
        }
    }
    
    func didAccountLinkResponses(with requestUrl:URL?, result: ACAccountLinkResult) {
        if let requestUrl = requestUrl{
            print(requestUrl.absoluteString)
        }
        
        switch result {
        case .Success:
            print("You are connected")
        case .Error(let type):
            print(type.localizedDescription)
        }
    }
}
```

## Any Question?
Please contact us Ramesh, ramesh@and-charge.me

## License

AndChargeAccountLink is available under the MIT license. See the LICENSE file for more info.

# Archi
A demo for networking architecture.

Before:
```swift
Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
         .responseJSON { response in
              // 1. Validate
              if response.result.isSuccess {
                // 2. Parse JSON data
                let object = JSONParseor(response.result.value)
                print(object)
              } else {
                // handle failure data
              }
         }
```
Alfter:
```swift
APIClient.events(arg1, arg2: arg2) { (result) in
    switch result {
        case let .Success(value):
            print(value)
        case let .Failure(status, description):
            print("status: \(status); description: \(description)")
    }
}
```

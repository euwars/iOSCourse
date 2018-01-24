import Dispatch
import Foundation
import Kitura
import PromiseKit

PromiseKit.conf.Q = (map: DispatchQueue.global(), return: DispatchQueue.global())

do {
    let router = try Store()
    Kitura.addHTTPServer(onPort: 8080, with: router.router)
    Kitura.run()
}catch let err{
    print(err.localizedDescription)
}

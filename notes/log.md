# Notes

## 180101
## Render a date picker



## Create a Day Core Data object

Save date into Day.date



## Get badges working!!!!!!!
Needed to import Notifications
```
import UserNotifications
```

And then do the request permission thing (this is NOT done in Info.plist
Privacy)
```
let center = UNUserNotificationCenter.current()
center.requestAuthorization(options: [.badge]) { (granted, error) in
    // Enable or disable features based on authorization.
}
```

https://stackoverflow.com/questions/37956482/registering-for-push-notifications-in-xcode-8-swift-3-0



## Date difference
Need to use NSCalendar
Extract out into helper function
Use a tuple



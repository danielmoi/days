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




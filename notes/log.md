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


Solution [180107]
- use a User model as well
- only have one "primary" user
- store `badgeDayId`, that references a Day record
- ie. "a User has one Day"

## Colors [180107]
- Assets catalog > new Color Set
- DefaultDay: rgb(231, 76, 60)


## Custom Table Cell [180107]
- use a custom table view cell
- render 2 text labels
- implement italics for the RHS label


## Text Field Capitalization [180107]
- `textField.autocapitalizationType = UITextAutocapitalizationTypeWords`

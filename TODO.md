# To Do

### General
- [x] Display "days since" / "days until" conditionally
- [x] Display the days difference in view title
- [x] Convert days to positive so badge always displays
- [x] Change days display upon interacting with date picker instead of on save
- [x] Save a name for the day as well
- [x] Update badge when it turns midnight
- [x] Implement toggle UI for setting default
- [x] Ensure only one default is set
- [x] Increment / decrement badge number
- [x] Remove all (the one) notifications if the default day is deleted
- [ ] Ask for permission when default is saved and we don't have permission


### Multiple days functionality
- [x] List of days
- [x] Tap day to view
- [x] Delete day
- [x] Swipe to delete
- [x] Select which one to set the badge to
- [x] Set default day to a different color in list view
- [x] Have day difference for all days in list view


## UX
- [x] Make keyboard go away when finished
- [x] Start textfield with a capital letter
- [ ] Implement "soft alert" before showing permissions dialog?
https://stackoverflow.com/questions/41946212/display-uilocalnotification-request-after-user-clicked-dont-allow


## Extra functionality
- [ ] Add notes to each day, what needs to be done [180119]
- [ ] Allow sorting of the days (by name)
- [ ] Allow sorting of the days (by date)
- [ ] Allow sorting of the days (manual - drag)
- [ ] Update rows after midnight passes, real-time, use timer instead of
  scheduling a local notification? [180120]
- [ ] Handle long names on list - need to truncate and ellipsis [180120]

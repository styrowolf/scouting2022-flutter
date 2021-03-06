# rapid_react_scouting

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Re-generating JSON Serialization Implementations

```sh
flutter pub run build_runner build
```

## Current Plan

Possible changes for better architecture:

- Use rebuilder in state but have a void method so it shows up as used and rebuilds


## Current Status

- [x] Implement all data models
- [x] Implement JSON Serialization
- [x] Implement working oauth2 client
- [x] Implement central state management with riverpod
- [x] Implement login flow
- [ ] Implement Tournament/Match view and creation screen
- [ ] Implement Scouting screen
- [ ] Implement Leaderboard screen
- [x] Implement Setting screen



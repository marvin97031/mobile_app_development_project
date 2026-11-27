# SmakBook

A Flutter recipe browser using [TheMealDB](https://www.themealdb.com/api.php).

## User Stories

1. **Sign up:** As a new user, I want to register with a username, email and password, so that I can have my own account.
2. **Log in:** As a registered user, I want to log in with my email and password and see an error if they are wrong, so that I can access my account.
3. **Home screen:** As a user, I want to see a list of recipes under the app logo, so that I can quickly find something to cook.
4. **Detail screen:** As a user, I want to open a recipe and read its details, so that I know how to prepare it.
5. **Local storage:** As a user, I want my favorite recipes saved on my device, so that they remain after I restart the app.
6. **External API:** As a user, I want to search recipes from an online service, so that I can discover new dishes.
7. **Settings menu:** As a user, I want a menu on the home screen, so that I can reach my profile, settings and notifications.
8. **Settings screen:** As a user, I want to switch dark mode on or off, so that the app is comfortable to use.
9. **Notifications:** As a user, I want to enable notifications and send a test alert, so that I know alerts work on my device.

## Running

```bash
flutter create . --platforms=android,web
flutter pub get
flutter run
```

Local notifications need Android setup (see the plugin documentation) and do not work in the web build.

## Limitations

Authentication is local and for demonstration only. Passwords are stored as SHA-256 hashes on the device; a production app needs server-side authentication.

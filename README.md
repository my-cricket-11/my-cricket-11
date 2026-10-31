# MY CRICKET 11 — Flutter starter

This is a **free-to-play prototype** for Android and iOS. It includes:
- Black + Gold visual theme
- Home screen with sample matches
- Local practice-team selection (11 players)
- Captain and vice-captain selection
- Sample practice leaderboard
- Guest profile screen

## Run locally

1. Install Flutter SDK and Android Studio / Xcode.
2. Extract this folder.
3. In this folder run:

   ```bash
   flutter pub get
   flutter run
   ```

## Important prototype limitations

- Match names, teams and players are demo data.
- Team selection is stored only in app memory; it is not a production database.
- No OTP, live scores, real player statistics, admin panel, payments or cash contests are implemented.
- Before publishing, connect a licensed cricket-data provider, production backend, authentication, monitoring, privacy/terms pages and app-store compliance checks.
- This starter is intentionally free-to-play. Do not add entry fees, deposits, cash prizes or withdrawals without a current legal review of Indian central/state law and platform/payment rules.

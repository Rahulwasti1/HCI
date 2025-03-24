# WattBot

A Flutter application for monitoring and managing energy consumption in homes. This app provides users with real-time energy usage data, room-by-room consumption breakdown, and an AI chatbot assistant for energy-saving tips.

## Features

- **User Authentication**: Sign in, sign up, and profile management
- **Energy Dashboard**: Real-time energy usage monitoring with visual charts
- **Room-wise Consumption**: Track energy usage by individual rooms
- **Time Frame Analysis**: View energy consumption data by day, week, month, or year
- **WattBot Assistant**: AI chatbot for energy-saving tips and assistance
- **Profile Management**: User profile customization and settings

## Screenshots

The app includes the following screens:

- Home Dashboard
- Sign In/Sign Up
- Profile Management
- Energy Monitoring
- WattBot Chat Interface
- Password Reset

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK (3.6.0 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:

```
git clone https://github.com/yourusername/energy-monitoring-app.git
```

2. Navigate to the project directory:

```
cd energy-monitoring-app
```

3. Install dependencies:

```
flutter pub get
```

4. Run the app:

```
flutter run
```

## Dependencies

- provider: ^6.1.2 - For state management
- fl_chart: ^0.66.2 - For energy usage charts
- shared_preferences: ^2.2.2 - For local storage
- intl: ^0.19.0 - For date formatting
- country_code_picker: ^3.0.0 - For phone number country code selection
- image_picker: ^1.0.7 - For profile image selection
- flutter_svg: ^2.0.10+1 - For SVG image support

## Project Structure

```
lib/
├── constants/       # App constants (colors, themes)
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
│   ├── auth/        # Authentication screens
│   ├── main/        # Main app screens
│   └── profile/     # Profile screens
├── widgets/         # Reusable widgets
└── main.dart        # App entry point
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

# HCI

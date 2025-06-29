
# Expense Tracker App

A cross-platform mobile app to manage and visualize personal daily expenses using interactive UI components and adaptive layout design.  
This project was built hands-on while following the “Flutter & Dart – The Complete Guide” Udemy course by Maximilian Schwarzmüller, with complete independent coding and understanding.

---

## Features
- Add, list, and delete expenses with real-time UI updates
- Chart widget to visualize weekly expense distribution
- Fully responsive layout for portrait & landscape orientation
- Adaptive widgets for Android & iOS using platform-aware UI

---

## Tech Stack
| Layer            | Libraries / Tools |
|------------------|-------------------|
| Core Framework   | Flutter 3, Dart 3 |
| State Handling   | setState           |
| Charts           | Custom Flutter widgets |
| Styling & Layout | Material 3, Cupertino |

---

## Architecture Overview
```
UI Layer (Widgets & Screens)
│
└── Logic Layer (stateful widgets managing dynamic data)
```

---

## Folder Structure
```
lib/
├── models/
│   └── expense.dart
├── widgets/
│   ├── chart.dart
│   ├── expense_form.dart
│   ├── expense_list.dart
│   └── expense_item.dart
└── main.dart
```

---

## Getting Started
1. **Prerequisites**
   - Flutter 3.x (stable)
   - Dart 3.x SDK
2. **Run Locally**
   ```bash
   git clone https://github.com/<your-user>/expense_tracker_app.git
   cd expense_tracker_app
   flutter pub get
   flutter run
   ```

---

## Roadmap
- Add persistent storage using Hive or SharedPreferences
- Add categories & filtering options
- Integrate Firebase for cloud sync
- Monthly analytics dashboard

---

## License
This project is licensed under the MIT License.

---

## Acknowledgements
Built as part of the “Flutter & Dart – The Complete Guide” Udemy course by Maximilian Schwarzmüller, with added structure and polish for clean deployment.
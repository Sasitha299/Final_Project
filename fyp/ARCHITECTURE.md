# Authentication Flow Architecture - SOLID Principles

## Overview
This implementation provides a complete splash screen → login screen → home screen flow with proper state management and SOLID principles.

## Project Structure
```
lib/
├── main.dart                          # Entry point
├── app.dart                           # App configuration & routing
├── data/
│   └── services/
│       └── auth_service.dart         # Authentication logic
├── logic/
│   └── controllers/
│       └── auth_controller.dart      # State management
├── routes/
│   └── app_routes.dart               # Route constants
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart        # Splash screen (3 sec initialization)
│   ├── login/
│   │   └── login_screen.dart         # Login form with validation
│   ├── home/
│   │   └── homescreen.dart           # Main app home
│   ├── others/
│   ├── news/
│   ├── profile/
│   └── time/
└── widgets/
    └── bottom_navigation.dart        # Bottom navigation bar
```

## SOLID Principles Implementation

### 1. **Single Responsibility Principle (SRP)**
Each class has one reason to change:
- `AuthService`: Only handles authentication logic
- `AuthController`: Only manages authentication state
- `SplashScreen`: Only shows loading animation
- `LoginScreen`: Only handles login UI
- `AppRoutes`: Only defines route constants

### 2. **Open/Closed Principle (OCP)**
Classes are open for extension but closed for modification:
- `IAuthService` interface allows adding new auth methods without modifying existing code
- New authentication providers can be added by implementing `IAuthService`

### 3. **Liskov Substitution Principle (LSP)**
Implementations can be substituted without breaking the code:
- `AuthService` implements `IAuthService` contract
- Can easily swap with another implementation (e.g., Firebase authentication)

### 4. **Interface Segregation Principle (ISP)**
Clients depend on specific interfaces:
- `IAuthService` defines only required auth methods
- `AuthController` depends on `IAuthService`, not concrete implementation
- No unnecessary dependencies

### 5. **Dependency Inversion Principle (DIP)**
High-level modules don't depend on low-level modules:
- `AuthController` depends on `IAuthService` interface
- `AuthService` implementation is injected via constructor
- Uses Provider package for dependency injection

## Authentication Flow

### 1. **Splash Screen** (3 seconds)
- Shows app logo with fade animation
- Initializes auth state
- Redirects to Login or Home based on authentication status

### 2. **Login Screen**
- Email/Password input fields
- Form validation (min 6 characters)
- Error display
- Loading state during authentication
- Navigates to Home on success

### 3. **Home Screen (MainLayout)**
- Bottom navigation with 5 screens
- Logout functionality
- Confirmation dialog before logout

## Key Features

### State Management
```dart
// Using Provider for state management
ChangeNotifierProvider<AuthController>(
  create: (context) => AuthController(
    authService: context.read<IAuthService>(),
  ),
)
```

### Dependency Injection
```dart
// Services are provided at app level
Provider<IAuthService>(
  create: (_) => AuthService(),
)
```

### Named Routes
All navigation uses named routes defined in `AppRoutes`:
```dart
Navigator.of(context).pushReplacementNamed(AppRoutes.home);
Navigator.of(context).pushReplacementNamed(AppRoutes.login);
```

## Authentication Logic

### Login Validation
- Username: Non-empty
- Password: Minimum 6 characters
- Simulates 2-second network delay

### Error Handling
- Error messages displayed in red box
- Snackbar notifications for user feedback
- Loading state during authentication

## How to Use

### Install Dependencies
```bash
flutter pub get
```

### Run the App
```bash
flutter run
```

### Test Login
- **Username**: Any non-empty value
- **Password**: Any value with minimum 6 characters
- After successful login, you'll be on the home screen

### Test Logout
- Click the "Logout" button in the app bar
- Confirm logout in the dialog
- You'll be redirected to login screen

## Extending the Architecture

### Add Firebase Authentication
1. Implement `IAuthService` with Firebase
```dart
class FirebaseAuthService implements IAuthService {
  @override
  Future<bool> login(String username, String password) async {
    // Firebase authentication logic
  }
}
```

2. Update dependency injection in `app.dart`
```dart
Provider<IAuthService>(
  create: (_) => FirebaseAuthService(),
)
```

### Add New Screens
1. Create screen in `screens/` folder
2. Add route in `app_routes.dart`
3. Add route case in `App._generateRoute()`
4. Update navigation logic

## Dependencies
- **provider**: ^6.0.0 (State management & dependency injection)
- **flutter**: ^3.9.2

## Future Enhancements
- [ ] Add flutter_secure_storage for token management
- [ ] Implement API integration
- [ ] Add biometric authentication
- [ ] Add remember me functionality
- [ ] Add password reset flow
- [ ] Add user profile management
- [ ] Add refresh token handling

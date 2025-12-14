# Architecture Diagram & Flow Charts

## System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      Flutter App                             │
│                     (main.dart)                              │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
        ┌──────────────────────────────────────┐
        │          App (app.dart)               │
        │  - MultiProvider Setup                │
        │  - Named Routes                       │
        │  - Theme Configuration                │
        └──────┬──────────────────────┬─────────┘
               │                      │
        ┌──────▼───────┐      ┌──────▼────────┐
        │  Providers   │      │   Screens     │
        │ (Dependency  │      │   (UI)        │
        │ Injection)   │      │               │
        └──────┬───────┘      └────────────────┘
               │
        ┌──────▼──────────────────────┐
        │  AuthController             │
        │  (State Management)          │
        │  ├─ isLoading               │
        │  ├─ errorMessage            │
        │  ├─ isAuthenticated         │
        │  └─ Methods: login(), logout│
        └──────┬──────────────────────┘
               │ (depends on)
        ┌──────▼──────────────────────┐
        │  IAuthService (Interface)    │
        │  ├─ login()                 │
        │  ├─ logout()                │
        │  └─ isUserLoggedIn()        │
        └──────┬──────────────────────┘
               │ (implemented by)
        ┌──────▼──────────────────────┐
        │  AuthService                │
        │  (Authentication Logic)      │
        │  - Handles login validation  │
        │  - Mock storage              │
        │  - 2 sec delay simulation    │
        └──────────────────────────────┘
```

## Dependency Injection Flow

```
┌─────────────────────────────────────────────┐
│         MultiProvider Setup (app.dart)       │
│  ┌──────────────────────────────────────┐   │
│  │ 1. Register IAuthService             │   │
│  │    └─ Create AuthService()           │   │
│  │                                       │   │
│  │ 2. Register AuthController           │   │
│  │    └─ Inject IAuthService from       │   │
│  │        context.read<IAuthService>()  │   │
│  └──────────────────────────────────────┘   │
└─────────────────┬──────────────────────────┘
                  │
        ┌─────────▼──────────┐
        │  Available to all  │
        │  Widgets via:      │
        │  - context.read()  │
        │  - Consumer<T>()   │
        │  - Watch()         │
        └────────────────────┘
```

## Authentication Flow Sequence

```
┌────────────────────────────────────────────────────────────┐
│ USER ACTION                   │ APP STATE                   │
├────────────────────────────────────────────────────────────┤
│                               │                             │
│ 1. App starts                 │ main() → App()              │
│    ↓                          │ ↓ Creates MultiProvider     │
│                               │                             │
│ 2. SplashScreen shows         │ Checks isUserLoggedIn()     │
│    (3 seconds)                │                             │
│    ↓                          │                             │
│                               │ ┌─ If authenticated:        │
│ 3. Check auth status          │ │  → Navigate to HomeScreen │
│    ↓                          │ │                            │
│                               │ └─ If not authenticated:    │
│ 4. Navigate to LoginScreen    │    → Navigate to LoginScreen│
│    ↓                          │                             │
│ 5. User enters credentials    │ authController.isLoading    │
│    ↓                          │ = true                      │
│                               │                             │
│ 6. Click "Sign In"            │ authService.login() called  │
│    ↓                          │ (2 sec delay)               │
│                               │                             │
│ 7. Validation happens:        │ ├─ Username not empty       │
│    - Username non-empty       │ ├─ Password length >= 6     │
│    - Password >= 6 chars      │ └─ Result: success/fail     │
│    ↓                          │                             │
│                               │ isAuthenticated = true      │
│ 8. Success → Navigate Home    │ errorMessage = null         │
│    OR                         │                             │
│    Error → Show message       │ errorMessage = error text   │
│    ↓                          │ isLoading = false           │
│                               │                             │
│ 9. On Home Screen             │ Display 5 screens          │
│    User taps tabs             │ Bottom navigation works    │
│    ↓                          │                             │
│                               │                             │
│ 10. Click Logout              │ Show confirmation dialog    │
│     ↓                          │                             │
│ 11. Confirm logout            │ authService.logout()       │
│     ↓                          │ isAuthenticated = false    │
│                               │                             │
│ 12. Navigate to LoginScreen   │ Ready for new login        │
│                               │                             │
└────────────────────────────────────────────────────────────┘
```

## SOLID Principles Visualization

```
┌──────────────────────────────────────────────────────────┐
│           SOLID Principles Implementation                 │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  S - Single Responsibility                              │
│  ├─ AuthService: Login logic only                       │
│  ├─ AuthController: State management only               │
│  ├─ SplashScreen: Splash UI only                        │
│  ├─ LoginScreen: Login UI only                          │
│  └─ AppRoutes: Route constants only                     │
│                                                          │
│  O - Open/Closed                                        │
│  ├─ IAuthService interface (open for extension)         │
│  ├─ Can add FirebaseAuthService without changing code   │
│  └─ Can add new auth methods to interface               │
│                                                          │
│  L - Liskov Substitution                                │
│  ├─ AuthService implements IAuthService                 │
│  ├─ Can be replaced with FirebaseAuthService            │
│  └─ Contract always maintained                          │
│                                                          │
│  I - Interface Segregation                              │
│  ├─ IAuthService has only 3 methods                     │
│  ├─ No unused/unnecessary dependencies                  │
│  └─ Clients only depend on what they need               │
│                                                          │
│  D - Dependency Inversion                               │
│  ├─ AuthController depends on IAuthService (abstract)   │
│  ├─ NOT on AuthService (concrete)                       │
│  └─ Provider handles the dependency injection           │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

## File Structure Diagram

```
lib/
├── main.dart                    ← Entry point (simplified)
├── app.dart                     ← App configuration & routing
│
├── data/
│   ├── models/
│   │   └── (future user models)
│   ├── repository/
│   │   └── (future data repos)
│   └── services/
│       └── auth_service.dart    ← Authentication logic
│
├── logic/
│   ├── controllers/
│   │   └── auth_controller.dart ← State management
│   └── providers/
│       └── (future providers)
│
├── routes/
│   └── app_routes.dart          ← Route constants
│
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart   ← Splash screen
│   ├── login/
│   │   └── login_screen.dart    ← Login form
│   ├── home/
│   │   └── homescreen.dart      ← Home screen
│   ├── news/
│   ├── others/
│   ├── profile/
│   └── time/
│
├── widgets/
│   └── bottom_navigation.dart   ← Bottom nav bar
│
├── config/
├── styles/
└── navigation/

pubspec.yaml                      ← Dependencies
```

## State Management Flow

```
┌──────────────────────────────────────────────────────┐
│            AuthController (ChangeNotifier)            │
├──────────────────────────────────────────────────────┤
│                                                      │
│  Properties:                                         │
│  ├─ _authService: IAuthService                      │
│  ├─ _isLoading: bool                                │
│  ├─ _errorMessage: String?                          │
│  └─ _isAuthenticated: bool                          │
│                                                      │
│  Methods:                                            │
│  ├─ login(username, password) → Future<bool>        │
│  ├─ logout() → Future<void>                         │
│  ├─ init() → Future<void>                           │
│  └─ clearError() → void                             │
│                                                      │
│  When property changes:                              │
│  └─ notifyListeners() → UI rebuilds                 │
│                                                      │
└────────────────────┬─────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
   ┌────▼──────────┐     ┌───────▼────────┐
   │  Consumer<>   │     │  context.read()│
   │   (Rebuilds   │     │  (No rebuild)  │
   │    on change) │     │                │
   └───────────────┘     └────────────────┘
        │                         │
   Widget rebuilds      Can use state
   when notified        without rebuild
```

## Route Navigation Map

```
┌──────────────────────────────────────────────────┐
│              App Routes Map                       │
├──────────────────────────────────────────────────┤
│                                                  │
│  '/'        → SplashScreen                       │
│              ├─ Check auth                       │
│              ├─ 3 second delay                   │
│              └─ Redirect based on auth           │
│                  ├─ Authenticated → '/home'      │
│                  └─ Not auth → '/login'          │
│                                                  │
│  '/login'   → LoginScreen                        │
│              ├─ Username input                   │
│              ├─ Password input                   │
│              ├─ Validate & login                 │
│              └─ Success → '/home'                │
│                  Failed → Show error             │
│                                                  │
│  '/home'    → MainLayout (Home)                  │
│              ├─ Bottom navigation                │
│              ├─ 5 screens:                       │
│              │  ├─ Home                          │
│              │  ├─ Time                          │
│              │  ├─ News                          │
│              │  ├─ Others                        │
│              │  └─ Profile                       │
│              └─ Logout button → '/login'         │
│                                                  │
│  '/time'    → TimeScreen                         │
│  '/news'    → NewsScreen                         │
│  '/others'  → OthersScreen                       │
│  '/profile' → ProfileScreen                      │
│                                                  │
└──────────────────────────────────────────────────┘
```

## Data Flow Diagram

```
User Input (LoginScreen)
    ↓
authController.login(username, password)
    ↓
authService.login(username, password)
    ├─ Validate input
    ├─ Simulate API call (2 sec)
    └─ Return success/fail
    ↓
AuthController updates state
    ├─ isLoading = false
    ├─ isAuthenticated = success
    ├─ errorMessage = error or null
    └─ notifyListeners()
    ↓
UI rebuilds with new state
    ├─ Navigate to home (success)
    └─ Show error message (fail)
```

## Comparison: Before & After

```
BEFORE                                    AFTER
┌──────────────────────┐              ┌──────────────────────┐
│ main.dart            │              │ main.dart            │
│ ├─ MyApp             │              │ ├─ Simple entry      │
│ ├─ MainLayout        │              │ └─ Delegates to App  │
│ └─ All logic mixed   │              │                      │
└──────────────────────┘              └──────────────────────┘
         ↓                                      ↓
    Hard to test                         Easy to test
    Mixed concerns                       Separated concerns
    Tightly coupled                      Loosely coupled
    Direct to home                       Proper auth flow
    No state management                  Provider state mgmt
    No navigation setup                  Named routes
```

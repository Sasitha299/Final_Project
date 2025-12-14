# Code Examples - Usage & Extension

## Basic Usage Examples

### 1. Accessing Auth State in Widgets

```dart
// In any widget, access auth state:
Consumer<AuthController>(
  builder: (context, authController, _) {
    if (authController.isAuthenticated) {
      return Text('User is logged in');
    }
    return Text('User is not logged in');
  },
)

// Or simpler, just read without rebuilding:
final authController = context.read<AuthController>();
print(authController.isAuthenticated);
```

### 2. Navigating After Login

```dart
// In LoginScreen after successful login:
if (success) {
  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
}

// Or manually handle:
if (authController.isAuthenticated) {
  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
}
```

### 3. Checking Auth Before Accessing Features

```dart
// In any screen/widget:
void _accessProtectedFeature() {
  final authController = context.read<AuthController>();
  
  if (authController.isAuthenticated) {
    // Allow access
    _doSomething();
  } else {
    // Redirect to login
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }
}
```

## Extension Examples

### 1. Replace with Firebase Authentication

Create `FirebaseAuthService`:

```dart
// lib/data/services/firebase_auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> login(String username, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Firebase error: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }
}
```

Update `app.dart`:

```dart
Provider<IAuthService>(
  create: (_) => FirebaseAuthService(), // Changed from AuthService
),
```

### 2. Add Email Verification

Extend `IAuthService`:

```dart
abstract class IAuthService {
  Future<bool> login(String username, String password);
  Future<void> logout();
  Future<bool> isUserLoggedIn();
  Future<void> sendVerificationEmail(); // New method
  Future<bool> isEmailVerified(); // New method
}
```

Implement in `AuthService`:

```dart
@override
Future<void> sendVerificationEmail() async {
  // Send verification email logic
}

@override
Future<bool> isEmailVerified() async {
  // Check if email is verified
  return true;
}
```

### 3. Add User Profile Model

Create `UserModel`:

```dart
// lib/data/models/user_model.dart
class UserModel {
  final String id;
  final String username;
  final String email;
  final String? profilePicture;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profilePicture,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
```

Extend `AuthService`:

```dart
class AuthService implements IAuthService {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  @override
  Future<bool> login(String username, String password) async {
    // ... login logic ...
    
    // After successful login, fetch user data
    _currentUser = UserModel(
      id: '1',
      username: username,
      email: '$username@example.com',
      createdAt: DateTime.now(),
    );
    
    return true;
  }
}
```

Extend `AuthController`:

```dart
class AuthController extends ChangeNotifier {
  UserModel? get currentUser {
    if (_authService is AuthService) {
      return (_authService as AuthService).currentUser;
    }
    return null;
  }
}
```

### 4. Add Remember Me Feature

Update `LoginScreen`:

```dart
class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  // In build method, add checkbox:
  CheckboxListTile(
    title: const Text('Remember me'),
    value: _rememberMe,
    onChanged: (value) {
      setState(() => _rememberMe = value ?? false);
    },
  )

  Future<void> _handleLogin(BuildContext context) async {
    final authController = context.read<AuthController>();
    final success = await authController.login(
      _usernameController.text.trim(),
      _passwordController.text,
    );

    if (success && _rememberMe) {
      // Save credentials securely
      // await _saveCredentials();
    }
  }
}
```

### 5. Add Biometric Authentication

Install package:

```yaml
dependencies:
  local_auth: ^2.1.0
```

Create `BiometricService`:

```dart
// lib/data/services/biometric_service.dart
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> canUseBiometrics() async {
    return await _localAuth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _localAuth.getAvailableBiometrics();
  }
}
```

Use in `SplashScreen`:

```dart
final biometricService = BiometricService();
final canUseBiometric = await biometricService.canUseBiometrics();

if (canUseBiometric && authController.isAuthenticated) {
  final authenticated = await biometricService.authenticate();
  if (authenticated) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  } else {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }
}
```

### 6. Add API Interceptor for Auth

Create `ApiClient`:

```dart
// lib/data/services/api_client.dart
import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  final IAuthService _authService;

  ApiClient({required IAuthService authService}) : _authService = authService;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Add auth token to headers
    // final token = await _authService.getToken();
    // request.headers['Authorization'] = 'Bearer $token';

    return super.send(request);
  }
}
```

### 7. Add Session Timeout

Extend `AuthController`:

```dart
class AuthController extends ChangeNotifier {
  Timer? _sessionTimer;
  final Duration _sessionTimeout = const Duration(minutes: 15);

  void startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(_sessionTimeout, () {
      logout(); // Auto logout after timeout
    });
  }

  void resetSessionTimer() {
    startSessionTimer(); // Reset on user activity
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }
}
```

Use in `MainLayout`:

```dart
@override
void initState() {
  super.initState();
  final authController = context.read<AuthController>();
  authController.startSessionTimer();
}

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.read<AuthController>().resetSessionTimer();
    },
    child: Scaffold(
      // ... rest of scaffold
    ),
  );
}
```

## Testing Examples

### Unit Test for AuthController

```dart
// test/logic/controllers/auth_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('AuthController', () {
    late MockAuthService mockAuthService;
    late AuthController authController;

    setUp(() {
      mockAuthService = MockAuthService();
      authController = AuthController(authService: mockAuthService);
    });

    test('login returns true on successful authentication', () async {
      when(mockAuthService.login('user', 'password123'))
          .thenAnswer((_) async => true);

      final result = await authController.login('user', 'password123');

      expect(result, true);
      expect(authController.isAuthenticated, true);
    });

    test('login returns false on failed authentication', () async {
      when(mockAuthService.login('user', 'wrong'))
          .thenAnswer((_) async => false);

      final result = await authController.login('user', 'wrong');

      expect(result, false);
      expect(authController.isAuthenticated, false);
    });
  });
}
```

## Performance Tips

1. **Lazy Load Screens**
   ```dart
   // Instead of const HomeScreen() in _pages list:
   final List<Widget> _pages = [
     _buildHomeScreen(),
     _buildOthersScreen(),
     // ...
   ];
   ```

2. **Use RepaintBoundary for Complex UIs**
   ```dart
   RepaintBoundary(
     child: YourComplexWidget(),
   )
   ```

3. **Cache API Responses**
   ```dart
   Map<String, dynamic> _userCache;
   
   Future<UserModel> getUser() async {
     if (_userCache != null) return UserModel.fromJson(_userCache);
     _userCache = await _api.fetchUser();
     return UserModel.fromJson(_userCache);
   }
   ```

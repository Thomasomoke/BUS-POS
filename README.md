

*BusPOS*

---

# **Architecture Reference Guide**


This document explains:
✅ Each folder
✅ What files go inside
✅ Why they exist
✅ Example code snippets

---

#  **1. Folder Structure Overview**

```
lib/
  core/
    config/
    errors/
    routing/
    theme/
    utils/
    services/

  common/
    widgets/
    models/
    helpers/

  features/
    auth/
      data/
      providers/
      presentation/
        screens/
        components/

    bookings/
      data/
      providers/
      presentation/
        screens/
        components/

  app.dart
  main.dart
```

---

#  **2. /core — Global Application Infrastructure**

Contains shared logic used by ALL features.

---

##  **2.1 /core/config**

### **app_constants.dart**

```dart
class AppConstants {
  static const currency = "KES";
  static const mpesaTimeout = Duration(seconds: 30);
}
```

### **app_env.dart**

```dart
class AppEnv {
  static const apiBaseUrl = String.fromEnvironment("API_URL");
}
```

---

##  **2.2 /core/errors**

### **exceptions.dart**

```dart
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}
```

### **failure.dart**

```dart
class Failure {
  final String message;
  Failure(this.message);
}
```

---

##  **2.3 /core/routing**

### **app_router.dart**

```dart
final router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/login", builder: (_,__) => const LoginScreen()),
    GoRoute(path: "/bookings", builder: (_,__) => const BookingsListScreen()),
    GoRoute(path: "/booking/new", builder: (_,__) => const BookingFormScreen()),
  ],
  redirect: routeGuard,
);
```

### **route_guards.dart**

```dart
String? routeGuard(_, GoRouterState state) {
  final session = SessionProvider.instance;

  if (!session.isLoggedIn) {
    return state.location == '/login' ? null : '/login';
  }

  return null;
}
```

---

##  **2.4 /core/theme**

### **app_theme.dart**

```dart
class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );
}
```

---

##  **2.5 /core/utils**

### **validators.dart**

```dart
String? validatePhone(String? value) {
  if (value == null || value.length != 10) return "Invalid phone";
  return null;
}
```

### **formatters.dart**

```dart
String formatCurrency(double amount) {
  return "KES ${amount.toStringAsFixed(0)}";
}
```

---

##  **2.6 /core/services**

### **http_client.dart**

```dart
class HttpClient {
  Future<Map<String, dynamic>> get(String url) async {
    final token = await SecureStorageService.getToken();
    // Add auth header, make API call, handle 401...
  }
}
```

### **secure_storage_service.dart**

```dart
class SecureStorageService {
  static Future<void> saveToken(String token) async { /* ... */ }
  static Future<String?> getToken() async { /* ... */ }
}
```

---

#  **3. /common — Shared UI & Helpers**

---

##  **3.1 /common/widgets**

### **app_button.dart**

```dart
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AppButton({required this.label, required this.onPressed});

  @override
  Widget build(context) =>
      ElevatedButton(onPressed: onPressed, child: Text(label));
}
```

### **app_input.dart**

```dart
class AppInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const AppInput({required this.label, required this.controller});
}
```

---

##  **3.2 /common/models**

* `api_response.dart`
* `pagination.dart`

---

##  **3.3 /common/helpers**

* `logger.dart`
* `debouncer.dart`

---

#  **4. features/auth — Authentication Module**

Handles:
✅ Login
✅ Session state
✅ Role-based UI
✅ Profile display

---

##  **4.1 data/**

### **auth_api.dart**

```dart
class AuthApi {
  Future<Map<String, dynamic>> login(String phone, String pin) async {
    return HttpClient().post("/auth/login", data: {
      "phone": phone,
      "pin": pin,
    });
  }
}
```

### **auth_repository.dart**

```dart
class AuthRepository {
  final api = AuthApi();

  Future<User> login(String phone, String pin) async {
    final json = await api.login(phone, pin);
    return User.fromJson(json);
  }
}
```

### **auth_models.dart**

```dart
class User {
  final String id;
  final String role;
  User({required this.id, required this.role});
}
```

---

##  **4.2 providers/**

### **auth_provider.dart**

```dart
class AuthProvider extends ChangeNotifier {
  final AuthRepository repo;

  bool loading = false;
  String? error;

  AuthProvider(this.repo);

  Future<void> login(String phone, String pin) async {
    loading = true;
    notifyListeners();

    try {
      final user = await repo.login(phone, pin);
      SessionProvider.instance.setUser(user);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
```

### **session_provider.dart**

```dart
class SessionProvider extends ChangeNotifier {
  static final instance = SessionProvider._();

  SessionProvider._();

  User? user;

  bool get isLoggedIn => user != null;

  void setUser(User u) {
    user = u;
    notifyListeners();
  }
}
```

---

##  **4.3 presentation/**

### **screens/login_screen.dart**

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      body: Center(child: LoginForm()),
    );
  }
}
```

### **components/login_form.dart**

```dart
class LoginForm extends StatelessWidget {
  final phoneController = TextEditingController();
  final pinController = TextEditingController();

  @override
  Widget build(context) {
    final provider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        AppInput(label: "Phone", controller: phoneController),
        AppInput(label: "PIN", controller: pinController),
        AppButton(
          label: provider.loading ? "Loading..." : "Login",
          onPressed: () {
            provider.login(
              phoneController.text,
              pinController.text,
            );
          },
        )
      ],
    );
  }
}
```

---

#  **5. features/bookings — Travel Booking Module**

Covers the full flow:
✅ Customer details
✅ Route & travel date
✅ Available vehicles
✅ Seat selection
✅ M-Pesa payment
✅ Ticket preview

---

##  **5.1 data/**

### **booking_api.dart**

```dart
class BookingApi {
  Future<List> getVehicles(String routeId, String date) =>
    HttpClient().get("/routes/$routeId/vehicles?date=$date");

  Future<List> getSeats(String vehicleId, String date) =>
    HttpClient().get("/vehicles/$vehicleId/seats?date=$date");
}
```

### **booking_repository.dart**

```dart
class BookingRepository {
  final api = BookingApi();

  Future<List<Vehicle>> fetchVehicles(routeId, date) async {
    final data = await api.getVehicles(routeId, date);
    return data.map((e) => Vehicle.fromJson(e)).toList();
  }
}
```

### **booking_models.dart**

```dart
class Vehicle {
  final String id;
  final String name;
}
```

---

##  **5.2 providers/**

### **booking_form_provider.dart**

```dart
class BookingFormProvider extends ChangeNotifier {
  String? selectedRoute;
  String? selectedVehicle;
  String? selectedSeat;

  void chooseRoute(String id) {
    selectedRoute = id;
    notifyListeners();
  }

  void chooseVehicle(String id) {
    selectedVehicle = id;
    notifyListeners();
  }

  void chooseSeat(String seat) {
    selectedSeat = seat;
    notifyListeners();
  }
}
```

---

##  **5.3 presentation/**

### **screens/booking_form_screen.dart**

```dart
class BookingFormScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Booking")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomerDetailsSection(),
            RouteSelector(),
            VehicleSelector(),
            SeatSelector(),
            PaymentSection(),
          ],
        ),
      ),
    );
  }
}
```

### **components/vehicle_selector.dart**

```dart
class VehicleSelector extends StatelessWidget {
  @override
  Widget build(context) {
    final provider = Provider.of<BookingFormProvider>(context);
  
    return DropdownButton<String>(
      value: provider.selectedVehicle,
      items: ["Bus A", "Bus B"].map((v) => DropdownMenuItem(
        value: v,
        child: Text(v),
      )).toList(),
      onChanged: provider.chooseVehicle,
    );
  }
}
```

---

#  **6. app.dart**

```dart
class App extends StatelessWidget {
  @override
  Widget build(context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(AuthRepository())),
        ChangeNotifierProvider(create: (_) => SessionProvider.instance),
        ChangeNotifierProvider(create: (_) => BookingFormProvider()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.light,
        routerConfig: router,
      ),
    );
  }
}
```

---

#  **7. main.dart**

```dart
void main() {
  runApp(const App());
}
```


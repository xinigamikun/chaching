import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'services/database_service.dart';
import 'services/android_sms_service.dart';
import 'services/notification_service.dart';
import 'services/encryption_service.dart';
import 'providers/onboarding_provider.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/help_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final databaseService = DatabaseService();
  final smsService = AndroidSmsService();
  final notificationService = NotificationService();
  final encryptionService = EncryptionService();
  final onboardingProvider = OnboardingProvider();

  // Initialize services in order
  await Future.wait([
    databaseService.initialize(),
    smsService.initialize(),
    notificationService.initialize(),
    encryptionService.initialize(),
    onboardingProvider.initialize(),
  ]);

  // Additional initialization steps
  await notificationService.requestPermissions();
  await databaseService.initializeEncryption(encryptionService);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: databaseService),
        Provider.value(value: smsService),
        Provider.value(value: notificationService),
        Provider.value(value: encryptionService),
        ChangeNotifierProvider.value(value: onboardingProvider),
      ],
      child: const ChachingApp(),
    ),
  );
}

class ChachingApp extends StatelessWidget {
  const ChachingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'ChaChing',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Consumer<OnboardingProvider>(
        builder: (context, onboarding, _) {
          if (!onboarding.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          return onboarding.onboardingCompleted
              ? const AppScaffold()
              : const OnboardingScreen();
        },
      ),
    );
  }
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ActivityScreen(),
    const ReportsScreen(),
  ];

  Widget _getScreenTitle() {
    switch (_currentIndex) {
      case 0:
        return const Text('Home');
      case 1:
        return const Text('Activity');
      case 2:
        return const Text('Reports');
      default:
        return const Text('ChaChing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _getScreenTitle(),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

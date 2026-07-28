import 'package:flutter/material.dart';

void main() {
  runApp(const TaskHubApp());
}

class TaskHubApp extends StatelessWidget {
  const TaskHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/user/dashboard': (context) => const UserDashboardScreen(),
        '/user/activation': (context) => const ActivationScreen(),
        '/admin/dashboard': (context) => const AdminDashboardScreen(),
      },
    );
  }
}

// --- MOCK APP STATE ---
class AppState {
  static bool isAccountActive = false;
  static double walletBalance = 0.0;
  static List<String> pendingActivations = [];
}

// --- LOGIN SCREEN ---
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, size: 80, color: Colors.teal),
                const SizedBox(height: 16),
                Text(
                  'Task Hub',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                ),
                const SizedBox(height: 32),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/user/dashboard'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                    child: const Text('Login as User'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/admin/dashboard'),
                    child: const Text('Login as Admin'),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Don\\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- USER DASHBOARD ---
class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Wallet Card
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Wallet Balance', style: TextStyle(fontSize: 16, color: Colors.teal)),
                    const SizedBox(height: 8),
                    Text(
                      '৳${AppState.walletBalance.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            if (!AppState.isAccountActive)
              Card(
                color: Colors.orange.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning, color: Colors.deepOrange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your account is not activated. You cannot start tasks.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/user/activation').then((_) => setState(() {}));
                        },
                        child: const Text('Activate Account Now'),
                      )
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),
            const Text('Available Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.play_arrow)),
                    title: Text('Watch Advertisement ${index + 1}'),
                    subtitle: const Text('Reward: ৳5.00'),
                    trailing: ElevatedButton(
                      onPressed: AppState.isAccountActive ? () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task completed!')));
                        setState(() {
                          AppState.walletBalance += 5.0;
                        });
                      } : null,
                      child: const Text('Start'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- ACTIVATION SCREEN ---
class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final TextEditingController _txIdController = TextEditingController();

  void _submitRequest() {
    if (_txIdController.text.isNotEmpty) {
      setState(() {
        AppState.pendingActivations.add(_txIdController.text);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Activation request sent to Admin!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activate Account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.verified_user, size: 64, color: Colors.teal),
                    const SizedBox(height: 16),
                    const Text(
                      'Account Activation Fee: ৳50',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    const Text('1. Send Money ৳50 to bKash/Nagad: 01643223886'),
                    const SizedBox(height: 8),
                    const Text('2. Enter your Transaction ID below'),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _txIdController,
                      decoration: const InputDecoration(
                        labelText: 'Transaction ID (e.g. 9XZ3...)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitRequest,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit Activation Request'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- ADMIN DASHBOARD ---
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildStatCard('Total Users', '152', Colors.blue),
                _buildStatCard('Active Users', '140', Colors.green),
                _buildStatCard('Pending Activations', '${AppState.pendingActivations.length}', Colors.orange),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Activation Requests', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (AppState.pendingActivations.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No pending requests.'),
              ),
            ...AppState.pendingActivations.map((txId) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.payment),
                    title: Text('TxID: $txId'),
                    subtitle: const Text('Amount: ৳50.00'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              AppState.isAccountActive = true;
                              AppState.pendingActivations.remove(txId);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Activated')));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              AppState.pendingActivations.remove(txId);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request Rejected')));
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

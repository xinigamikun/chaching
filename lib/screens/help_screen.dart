import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Documentation'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Getting Started',
            icon: Icons.start,
            content: [
              'Welcome to ChaChing - your personal finance tracker!',
              'Track expenses, split bills, and manage your finances with ease.',
              'This guide will help you understand all the features available.',
            ],
          ),
          _buildSection(
            context,
            title: 'Adding Expenses',
            icon: Icons.add_circle,
            content: [
              '1. Tap the + button on the home screen',
              '2. Enter expense details (amount, category, date)',
              '3. Add notes or attach receipts if needed',
              '4. Choose to split the bill if shared with others',
              '5. Save to record the expense',
            ],
          ),
          _buildSection(
            context,
            title: 'SMS Detection',
            icon: Icons.sms,
            content: [
              'The app automatically detects expenses from SMS notifications',
              'Supported banks and formats are automatically recognized',
              'You can review and categorize detected transactions',
              'Enable SMS permissions for this feature to work',
            ],
          ),
          _buildSection(
            context,
            title: 'Bill Splitting',
            icon: Icons.group,
            content: [
              'Split expenses equally or by custom amounts',
              'Add participants from your contacts',
              'Track who has paid their share',
              'Send reminders to pending participants',
              'Generate and share bill summaries',
            ],
          ),
          _buildSection(
            context,
            title: 'Reports & Analytics',
            icon: Icons.bar_chart,
            content: [
              'View spending patterns by category',
              'Monthly and yearly expense breakdowns',
              'Export reports as PDF',
              'Set and track budget goals',
              'Compare expenses across different periods',
            ],
          ),
          _buildSection(
            context,
            title: 'Security',
            icon: Icons.security,
            content: [
              'All your data is encrypted',
              'Use biometric authentication for added security',
              'Regular backups to prevent data loss',
              'Privacy-focused design - your data stays on your device',
            ],
          ),
          _buildSection(
            context,
            title: 'Troubleshooting',
            icon: Icons.help,
            content: [
              'Ensure SMS permissions are granted for auto-detection',
              'Check internet connection for cloud features',
              'Restart the app if you encounter any issues',
              'Contact support for additional help',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<String> content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((text) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'This Month';
  final List<String> _periods = ['This Month', 'Last Month', '3 Months', '6 Months', 'Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _periods.map((period) {
                final isSelected = period == _selectedPeriod;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(period),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedPeriod = period;
                        });
                      }
                    },
                    backgroundColor: isSelected ? AppTheme.primary : null,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _TotalSpendingCard(),
          SizedBox(height: 16),
          _CategoryBreakdownCard(),
          SizedBox(height: 16),
          _SpendingTrendCard(),
          SizedBox(height: 16),
          _TopSpendingCard(),
        ],
      ),
    );
  }
}

class _TotalSpendingCard extends StatelessWidget {
  const _TotalSpendingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Spending',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SpendingMetric(
                  title: 'Total',
                  amount: '₹15,420',
                  trend: '+12%',
                  isPositive: false,
                ),
                _SpendingMetric(
                  title: 'Average/Day',
                  amount: '₹514',
                  trend: '-5%',
                  isPositive: true,
                ),
                _SpendingMetric(
                  title: 'Highest Day',
                  amount: '₹2,100',
                  date: '15 Aug',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SpendingMetric extends StatelessWidget {
  final String title;
  final String amount;
  final String? trend;
  final bool? isPositive;
  final String? date;

  const _SpendingMetric({
    required this.title,
    required this.amount,
    this.trend,
    this.isPositive,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (trend != null)
          Text(
            trend!,
            style: TextStyle(
              color: isPositive! ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        if (date != null)
          Text(
            date!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

class _CategoryBreakdownCard extends StatelessWidget {
  const _CategoryBreakdownCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Breakdown',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // TODO: Add pie chart here
            const SizedBox(height: 16),
            const _CategoryBreakdownItem(
              category: 'Food',
              amount: 5200,
              percentage: 35,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            const _CategoryBreakdownItem(
              category: 'Transport',
              amount: 3100,
              percentage: 20,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            const _CategoryBreakdownItem(
              category: 'Entertainment',
              amount: 2800,
              percentage: 18,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryBreakdownItem extends StatelessWidget {
  final String category;
  final double amount;
  final int percentage;
  final Color color;

  const _CategoryBreakdownItem({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(category),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 40,
          child: Text(
            '$percentage%',
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _SpendingTrendCard extends StatelessWidget {
  const _SpendingTrendCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Trend',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // TODO: Add line chart here
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Chart will be added here',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopSpendingCard extends StatelessWidget {
  const _TopSpendingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Spending',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Movie Night'),
                  subtitle: Text(
                    '15 Aug • Entertainment',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: const Text('₹2,100'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
// payment_model.dart
import 'package:flutter/material.dart';
import 'package:nice_village/Localization/app_localizations.dart';

class PaymentRecord {
  final String month;
  final String year;
  final bool isPaid;
  final String subtitle;
  final String? receiptUrl;

  PaymentRecord({
    required this.month,
    required this.year,
    required this.isPaid,
    required this.subtitle,
    this.receiptUrl,
  });
}

// payment_list.dart
final List<PaymentRecord> paymentRecords = [
  PaymentRecord(
    month: 'February',
    year: '2024',
    isPaid: true,
    subtitle: 'The rent paid',
    receiptUrl: 'assets/rec.png',
  ),
  PaymentRecord(
    month: 'March',
    year: '2024',
    isPaid: true,
    subtitle: 'you have to pay',
    receiptUrl: 'assets/rec.png',
  ),
  PaymentRecord(
    month: 'April',
    year: '2024',
    isPaid: true,
    subtitle: 'The rent paid',
    receiptUrl: 'assets/rec.png',
  ),
  PaymentRecord(
    month: 'May',
    year: '2024',
    isPaid: false,
    subtitle: 'you have to pay',
    receiptUrl: null,
  ),
];

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  void _showReceiptDialog(BuildContext context, PaymentRecord payment) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (payment.isPaid && payment.receiptUrl != null) ...[
                Image.asset(
                  payment.receiptUrl!,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ] else ...[
                const Icon(
                  Icons.warning_rounded,
                  size: 64,
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)?.translate('paymentRequired') ??
                      'paymentRequired',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.translate("close")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.translate("payment"),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paymentRecords.length,
        itemBuilder: (context, index) {
          final payment = paymentRecords[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                payment.isPaid ? Icons.check_circle : Icons.cancel,
                color: payment.isPaid ? Colors.green : Colors.red,
                size: 28,
              ),
              title: Text(
                '${payment.month} ${payment.year}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              subtitle: Text(
                payment.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.receipt_long,
                  size: 35,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                onPressed: () => _showReceiptDialog(context, payment),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
          );
        },
      ),
    );
  }
}

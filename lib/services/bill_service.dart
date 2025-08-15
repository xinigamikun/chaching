import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/expense.dart';
import '../models/user.dart';

class BillService {
  /// Generate a PDF bill for an expense and return the file path
  Future<String> generateBill(Expense expense, List<User> participants) async {
    final pdf = pw.Document();

    // Create PDF content
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Header(
                level: 0,
                child: pw.Text('Expense Bill', style: pw.TextStyle(fontSize: 24)),
              ),
              pw.SizedBox(height: 20),

              // Basic Info
              pw.Text('Date: ${_formatDate(expense.date)}'),
              pw.Text('Description: ${expense.title}'),
              pw.Text('Category: ${expense.category}'),
              pw.SizedBox(height: 20),

              // Amount
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total Amount:'),
                    pw.Text(
                      '₹${expense.amount.toStringAsFixed(2)}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Participants
              pw.Header(level: 1, child: pw.Text('Split Details')),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Participant'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Share Amount'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('Status'),
                      ),
                    ],
                  ),
                  // Participant rows
                  ...expense.participants.map((participant) {
                    final user = participants.firstWhere(
                      (u) => u.id == participant.userId,
                      orElse: () => User(
                        id: participant.userId,
                        name: 'Unknown User',
                        email: '',
                        createdAt: DateTime.now(),
                      ),
                    );
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(user.name),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text('₹${participant.share.toStringAsFixed(2)}'),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            participant.hasPaid ? 'Paid' : 'Pending',
                            style: pw.TextStyle(
                              color: participant.hasPaid
                                  ? PdfColors.green
                                  : PdfColors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.SizedBox(height: 20),

              // Payment Instructions
              pw.Header(level: 1, child: pw.Text('Payment Instructions')),
              pw.SizedBox(height: 10),
              pw.Text(
                'Please settle your share of the expense with the person who paid.',
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Note: This is an automatically generated bill.',
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save the PDF
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/expense_${expense.id}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  /// Share the generated bill
  Future<void> shareBill(String filePath) async {
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: 'Expense Bill',
      text: 'Here\'s the expense bill for your reference.',
    );
  }

  /// Generate and share a bill in one step
  Future<void> generateAndShareBill(Expense expense, List<User> participants) async {
    final filePath = await generateBill(expense, participants);
    await shareBill(filePath);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
// announcements_page.dart
import 'package:flutter/material.dart';

class Announcement {
  final String title;
  final String date;
  final String content;

  Announcement({
    required this.title,
    required this.date,
    required this.content,
  });
}

class AnnouncementsPage extends StatelessWidget {
  final List<Announcement> announcements = [
    Announcement(
      title: 'Attention',
      date: 'Dec 20, 2024',
      content:
          'all homebuyers and real estate enthusiasts! We are excited to announce our latest listings',
    ),
    Announcement(
      title: 'Attention',
      date: 'Dec 20, 2024',
      content:
          'we have something for everyone. Our properties feature stunning designs and beautiful locations',
    ),
  ];

  AnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Announcements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notification_important,
                          color: Color(0xFFDEA30D)),
                      const SizedBox(width: 8),
                      Text(
                        announcements[index].title,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        announcements[index].date,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    announcements[index].content,
                    style: TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

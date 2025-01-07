// posts_page.dart
import 'package:flutter/material.dart';

class Post {
  final String username;
  final String date;
  final String content;

  Post({
    required this.username,
    required this.date,
    required this.content,
  });
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final List<Post> posts = [
    Post(
      username: 'User Name',
      date: 'Dec 20, 2024',
      content:
          'A house owner is an individual or entity that holds the title to a property, giving them.',
    ),
    Post(
      username: 'User Name',
      date: 'Dec 20, 2024',
      content:
          'A house owner is an individual or entity that holds the title to a property, giving them.',
    ),
    Post(
      username: 'User Name',
      date: 'Dec 20, 2024',
      content:
          'A house owner is an individual or entity that holds the title to a property, giving them.',
    ),
  ];

  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _showNewPostSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _postController,
                decoration: InputDecoration(
                  labelText: 'New Post',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_postController.text.isNotEmpty) {
                    setState(() {
                      posts.insert(
                        0,
                        Post(
                          username: 'User Name',
                          date: 'Dec 20, 2024',
                          content: _postController.text,
                        ),
                      );
                    });
                    _postController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Post'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).cardColor,
                        child: const Icon(Icons.person),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        posts[index].username,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        posts[index].date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    posts[index].content,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewPostSheet,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

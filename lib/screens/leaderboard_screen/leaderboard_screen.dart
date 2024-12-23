import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData = [
    {
      'subject': 'Mathematics',
      'topics': [
        {
          'topic': 'Algebra',
          'leaderboard': [
            {'rank': 1, 'name': 'John Doe', 'score': 95},
            {'rank': 2, 'name': 'Jane Smith', 'score': 90},
            {'rank': 3, 'name': 'Emily Davis', 'score': 85},
          ],
        },
        {
          'topic': 'Geometry',
          'leaderboard': [
            {'rank': 1, 'name': 'Michael Lee', 'score': 88},
            {'rank': 2, 'name': 'Sophia Wilson', 'score': 80},
          ],
        },
      ],
    },
    {
      'subject': 'Science',
      'topics': [
        {
          'topic': 'Physics',
          'leaderboard': [
            {'rank': 1, 'name': 'Robert Brown', 'score': 93},
            {'rank': 2, 'name': 'Linda Scott', 'score': 89},
          ],
        },
      ],
    },
  ];

   LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSubjectDropdown(),
            SizedBox(height: 16),
            Expanded(child: _buildTopicLeaderboard()),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Subject',
        border: OutlineInputBorder(),
      ),
      items: leaderboardData.map((subject) {
        return DropdownMenuItem<String>(
          value: subject['subject'] as String,
          child: Text(subject['subject'] as String),
        );
      }).toList(),
      onChanged: (value) {
        // Update selected subject and refresh topic list
      },
    );
  }


  Widget _buildTopicLeaderboard() {
    final selectedSubject = leaderboardData[0]; // Replace with state management
    final topics = selectedSubject['topics'] as List;

    return ListView.builder(
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return ExpansionTile(
          title: Text(topic['topic']),
          children: _buildLeaderboardItems(topic['leaderboard']),
        );
      },
    );
  }

  List<Widget> _buildLeaderboardItems(List<dynamic> leaderboard) {
    return leaderboard.map((entry) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text('#${entry['rank']}'),
        ),
        title: Text(entry['name']),
        subtitle: Text('Score: ${entry['score']}'),
        trailing: Icon(Icons.star, color: Colors.yellow),
      );
    }).toList();
  }
}

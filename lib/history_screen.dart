import 'package:flutter/material.dart';
import 'db_helper.dart';

class HistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> history;

  HistoryScreen({required this.history});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late List<Map<String, dynamic>> _history;

  @override
  void initState() {
    super.initState();
    _history = List.from(widget.history); // Copie mutable de l'historique
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
      ),
      body: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_history[index]['data']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await DatabaseHelper().deleteHistory(_history[index]['id']);
                setState(() {
                  _history.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper().clearHistory();
          setState(() {
            _history.clear();
          });
        },
        child: Icon(Icons.delete_sweep),
        tooltip: 'Clear History',
      ),
    );
  }
}

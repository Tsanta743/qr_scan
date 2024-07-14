import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateFromTextScreen()),
                );
              },
              child: Text('Generate from Text'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateFromFieldsScreen()),
                );
              },
              child: Text('Generate from Fields'),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateFromTextScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenerateFromTextScreenState();
}

class _GenerateFromTextScreenState extends State<GenerateFromTextScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code from Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Generate QR Code'),
            ),
            if (textController.text.isNotEmpty)
              QrImageView(
                data: textController.text,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}

class GenerateFromFieldsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenerateFromFieldsScreenState();
}

class _GenerateFromFieldsScreenState extends State<GenerateFromFieldsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController otherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code from Fields'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Surname',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otherController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Other',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Generate QR Code'),
            ),
            if (nameController.text.isNotEmpty ||
                surnameController.text.isNotEmpty ||
                numberController.text.isNotEmpty ||
                addressController.text.isNotEmpty ||
                otherController.text.isNotEmpty)
              QrImageView(
                data:
                    'Name: ${nameController.text}\nSurname: ${surnameController.text}\nNumber: ${numberController.text}\nAddress: ${addressController.text}\nOther: ${otherController.text}',
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}

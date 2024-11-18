import 'package:flutter/material.dart';

class StationInputWidget extends StatefulWidget {
  final Function(String) onImageUrlSubmitted;
  final Function(String, bool) onStationDataSubmitted;

  const StationInputWidget({
    Key? key,
    required this.onImageUrlSubmitted,
    required this.onStationDataSubmitted,
  }) : super(key: key);

  @override
  _StationInputWidgetState createState() => _StationInputWidgetState();
}

class _StationInputWidgetState extends State<StationInputWidget> {
  String _imageUrl = '';
  bool _isGreenHouse = true;
  final TextEditingController _stationNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Parte superior: cuadro para ingresar URL de imagen
          GestureDetector(
            onTap: () async {
              final String? url = await _showUrlInputDialog(context);
              if (url != null) {
                setState(() {
                  _imageUrl = url;
                });
                widget.onImageUrlSubmitted(_imageUrl);
              }
            },
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: _imageUrl.isEmpty
                  ? const Center(
                child: Text(
                  'Tap to add image URL',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : Image.network(
                _imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Parte inferior: switch y campo de texto
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('GreenHouse / Microculture'),
              Switch(
                value: _isGreenHouse,
                onChanged: (value) {
                  setState(() {
                    _isGreenHouse = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _stationNameController,
            decoration: const InputDecoration(
              labelText: 'Station Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final stationName = _stationNameController.text.trim();
              if (stationName.isNotEmpty) {
                widget.onStationDataSubmitted(
                    stationName, _isGreenHouse);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a station name')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showUrlInputDialog(BuildContext context) async {
    String url = '';
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Image URL'),
          content: TextField(
            onChanged: (value) {
              url = value;
            },
            decoration: const InputDecoration(hintText: 'Enter URL'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(url),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

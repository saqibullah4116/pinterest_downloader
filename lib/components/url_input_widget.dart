import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinterest_downloader/utils/constants.dart'; // For Clipboard

class UrlInputWidget extends StatefulWidget {
  final TextEditingController controller;

  const UrlInputWidget({super.key, required this.controller});

  @override
  _UrlInputWidgetState createState() => _UrlInputWidgetState();
}

class _UrlInputWidgetState extends State<UrlInputWidget> {
  bool _isUrlPasted = false;

  Future<void> _pasteUrl() async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      widget.controller.text = clipboardData.text!;
      setState(() {
        _isUrlPasted = true;
      });
    }
  }

  void _clearUrl() {
    widget.controller.clear();
    setState(() {
      _isUrlPasted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: AppStrings.enterUrlHint,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(_isUrlPasted ? Icons.clear : Icons.paste),
          onPressed: _isUrlPasted ? _clearUrl : _pasteUrl,
          tooltip: _isUrlPasted ? 'Clear URL' : 'Paste URL',
        ),
      ],
    );
  }
}
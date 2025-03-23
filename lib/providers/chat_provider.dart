import 'package:flutter/material.dart';
import 'package:hci/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class ChatProvider with ChangeNotifier {
  List<MessageModel> _messages = [];
  bool _isLoading = false;

  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getString('chat_messages');

      if (messagesJson != null) {
        final List<dynamic> decodedMessages = json.decode(messagesJson);
        _messages =
            decodedMessages.map((item) => MessageModel.fromJson(item)).toList();
      } else {
        // Initialize with a welcome message
        _messages = [
          MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content:
                'Hi there! I\'m WattBot, your virtual energy assistant. How can I help you today?',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        ];

        await _saveMessages();
      }
    } catch (e) {
      // Handle error
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    await _saveMessages();

    // Simulate bot typing
    _setLoading(true);
    await Future.delayed(const Duration(milliseconds: 1500));
    _setLoading(false);

    // Generate bot response
    final botResponse = await _generateBotResponse(content);
    _messages.add(botResponse);
    notifyListeners();

    await _saveMessages();
  }

  Future<MessageModel> _generateBotResponse(String userMessage) async {
    // Simple rule-based responses for demo
    final lowerUserMessage = userMessage.toLowerCase();

    // Energy saving tips
    if (lowerUserMessage.contains('reduce') &&
        (lowerUserMessage.contains('power') ||
            lowerUserMessage.contains('energy') ||
            lowerUserMessage.contains('usage'))) {
      return MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content:
            'Reduce power usage by switching to energy-efficient appliances, sealing drafts, using smart thermostats, and unplugging devices when not in use.',
        isUser: false,
        timestamp: DateTime.now(),
      );
    }

    // Energy overuse warning (randomly triggered)
    if (Random().nextInt(10) == 0) {
      await Future.delayed(const Duration(milliseconds: 500));

      final warningMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: 'There has been an energy overuse.',
        isUser: false,
        timestamp: DateTime.now(),
        type: MessageType.warning,
      );

      _messages.add(warningMessage);
      notifyListeners();
      await _saveMessages();
    }

    // Default responses
    final defaultResponses = [
      'I can help you monitor your energy usage and suggest ways to save power.',
      'Would you like to see a breakdown of your energy consumption by room or appliance?',
      'I can set up alerts for unusual energy consumption patterns if you\'d like.',
      'I\'m here to answer any questions about your energy usage and provide energy-saving tips.',
    ];

    return MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: defaultResponses[Random().nextInt(defaultResponses.length)],
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  Future<void> _saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson =
          json.encode(_messages.map((m) => m.toJson()).toList());
      await prefs.setString('chat_messages', messagesJson);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> clearChat() async {
    _setLoading(true);
    try {
      _messages = [
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content:
              'Hi there! I\'m WattBot, your virtual energy assistant. How can I help you today?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ];

      await _saveMessages();
    } catch (e) {
      // Handle error
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/models/message_model.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('h:mm a').format(message.timestamp);

    if (message.type == MessageType.warning) {
      return _buildWarningMessage();
    }

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: Icon(
                      Icons.smart_toy_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            Text(
              message.content,
              style: TextStyle(
                color: message.isUser ? Colors.white : AppColors.text,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timeString,
                style: TextStyle(
                  fontSize: 10,
                  color: message.isUser ? Colors.white70 : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Warning Message',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.content,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You can insert a description for the message here.The text relates to the action that has been performed.',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

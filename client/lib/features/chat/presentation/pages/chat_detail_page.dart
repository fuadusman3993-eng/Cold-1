import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  const ChatDetailPage({super.key, required this.chatId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _ctrl = TextEditingController();
  final _messages = <Map<String, dynamic>>[
    {'text': 'Hello, is this vehicle still available?', 'isMe': false, 'time': '2:15 PM'},
    {'text': 'Yes, it is! Are you interested?', 'isMe': true, 'time': '2:18 PM'},
    {'text': 'Yes very much. Is the price negotiable?', 'isMe': false, 'time': '2:30 PM'},
  ];

  void _sendMessage() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _ctrl.text.trim(), 'isMe': true, 'time': 'Now'});
      _ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgSecondary,
        title: const Row(
          children: [
            CircleAvatar(radius: 18, backgroundColor: AppColors.goldPrimary, child: Text('A', style: TextStyle(color: AppColors.textInverse, fontWeight: FontWeight.w700))),
            SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Abebe Kebede', style: TextStyle(fontSize: 15, color: AppColors.textPrimary)),
              Text('2022 Toyota Corolla', style: TextStyle(fontSize: 11, color: AppColors.goldPrimary)),
            ]),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.s4),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                final isMe = msg['isMe'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s3),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) ...[
                        const CircleAvatar(radius: 16, backgroundColor: AppColors.goldPrimary, child: Text('A', style: TextStyle(color: AppColors.textInverse, fontSize: 12, fontWeight: FontWeight.w700))),
                        const SizedBox(width: 8),
                      ],
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.goldPrimary : AppColors.bgSecondary,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMe ? 16 : 4),
                            bottomRight: Radius.circular(isMe ? 4 : 16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(msg['text'] as String, style: TextStyle(fontSize: 14, color: isMe ? AppColors.textInverse : AppColors.textPrimary)),
                            const SizedBox(height: 4),
                            Text(msg['time'] as String, style: TextStyle(fontSize: 10, color: isMe ? AppColors.textInverse.withOpacity(0.7) : AppColors.textTertiary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(AppSpacing.s4, AppSpacing.s3, AppSpacing.s4, MediaQuery.of(context).padding.bottom + AppSpacing.s3),
            decoration: BoxDecoration(color: AppColors.bgSecondary, border: Border(top: BorderSide(color: AppColors.borderSubtle))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: AppColors.borderSubtle)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: AppColors.borderSubtle)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppColors.goldPrimary)),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                    child: const Icon(Icons.send, color: AppColors.textInverse, size: 20),
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

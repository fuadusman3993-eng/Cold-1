import 'package:flutter/material.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class AIAssistantWidget extends StatefulWidget {
  const AIAssistantWidget({super.key});
  @override
  State<AIAssistantWidget> createState() => _AIAssistantWidgetState();
}

class _AIAssistantWidgetState extends State<AIAssistantWidget> {
  bool _isOpen = false;
  final _ctrl = TextEditingController();
  final _messages = <Map<String, dynamic>>[
    {'text': 'Hi! I am EthioDrive AI. I can help you find cars, estimate prices, or compare models.', 'isMe': false},
  ];

  @override
  Widget build(BuildContext context) {
    if (!_isOpen) {
      return FloatingActionButton(
        onPressed: () => setState(() => _isOpen = true),
        backgroundColor: AppColors.goldPrimary,
        child: const Icon(Icons.auto_awesome, color: AppColors.bgPrimary),
      );
    }

    return Container(
      width: 320,
      height: 480,
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
        ],
        border: Border.all(color: AppColors.goldPrimary.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3),
            decoration: const BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.textInverse, size: 20),
                const SizedBox(width: AppSpacing.s2),
                const Text('EthioDrive AI', style: TextStyle(color: AppColors.textInverse, fontWeight: FontWeight.w700, fontSize: 16)),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _isOpen = false),
                  child: const Icon(Icons.close, color: AppColors.textInverse, size: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.s3),
              itemCount: _messages.length,
              itemBuilder: (ctx, i) {
                final msg = _messages[i];
                final isMe = msg['isMe'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.s3),
                  child: Row(
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 240),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.goldPrimary : AppColors.bgTertiary,
                          borderRadius: BorderRadius.circular(16).copyWith(
                            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
                          ),
                        ),
                        child: Text(msg['text'] as String, style: TextStyle(
                          fontSize: 13, color: isMe ? AppColors.textInverse : AppColors.textPrimary,
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.s3),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderSubtle)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Ask me anything...',
                      hintStyle: const TextStyle(fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      filled: true, fillColor: AppColors.bgTertiary,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: AppSpacing.s2),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 36, height: 36,
                    decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle),
                    child: const Icon(Icons.send, color: AppColors.textInverse, size: 16),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_ctrl.text.isEmpty) return;
    setState(() {
      _messages.add({'text': _ctrl.text, 'isMe': true});
      final q = _ctrl.text.toLowerCase();
      _ctrl.clear();
      
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        String reply = "I can help you find listings! Just tell me your budget and preferred brand.";
        if (q.contains('price') || q.contains('value')) {
          reply = "Based on current Ethiopian market data, a 2022 Toyota Corolla goes for around 3.2M to 3.8M ETB.";
        }
        setState(() => _messages.add({'text': reply, 'isMe': false}));
      });
    });
  }
}

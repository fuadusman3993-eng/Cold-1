import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  final _chats = const [
    {'name': 'Abebe Kebede', 'lastMsg': 'Is the price negotiable?', 'time': '2:30 PM', 'unread': 2, 'vehicle': '2022 Toyota Corolla'},
    {'name': 'Tigist Alemu', 'lastMsg': 'Can I schedule a test drive?', 'time': '11:15 AM', 'unread': 0, 'vehicle': '2021 Hyundai Tucson'},
    {'name': 'Yonas Haile', 'lastMsg': 'Thank you for your response.', 'time': 'Yesterday', 'unread': 0, 'vehicle': '2019 Toyota Land Cruiser'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(title: const Text('Messages'), backgroundColor: AppColors.bgPrimary),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
        itemCount: _chats.length,
        separatorBuilder: (_, __) => Divider(color: AppColors.borderSubtle, height: 1, indent: 80),
        itemBuilder: (ctx, i) {
          final chat = _chats[i];
          final hasUnread = (chat['unread'] as int) > 0;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s2),
            leading: CircleAvatar(
              radius: 26, backgroundColor: AppColors.goldPrimary,
              child: Text((chat['name'] as String)[0], style: const TextStyle(color: AppColors.textInverse, fontWeight: FontWeight.w700, fontSize: 18)),
            ),
            title: Row(
              children: [
                Expanded(child: Text(chat['name'] as String, style: TextStyle(fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary))),
                Text(chat['time'] as String, style: TextStyle(fontSize: 11, color: hasUnread ? AppColors.goldPrimary : AppColors.textTertiary)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(chat['vehicle'] as String, style: const TextStyle(fontSize: 11, color: AppColors.goldPrimary)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(child: Text(chat['lastMsg'] as String, style: TextStyle(fontSize: 13, color: hasUnread ? AppColors.textPrimary : AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    if (hasUnread)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.goldPrimary, borderRadius: BorderRadius.circular(10)),
                        child: Text('${chat['unread']}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textInverse)),
                      ),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Navigate to the chat detail page
              // Since this is mock data, we just use a dummy ID '1'
              context.push('/chat/1');
            },
          );
        },
      ),
    );
  }
}

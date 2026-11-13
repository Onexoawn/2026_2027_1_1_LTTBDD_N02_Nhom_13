import 'package:flutter/material.dart';

import '../model/member.dart';

class GroupInfoScreen extends StatelessWidget {
  final String currentLang;

  const GroupInfoScreen({super.key, required this.currentLang});

  Widget _buildMemberAvatar(String avatarUrl) {
    final fallbackAvatar = Container(
      width: 52,
      height: 52,
      color: Colors.deepOrange.shade100,
      child: const Icon(Icons.person, color: Colors.deepOrange, size: 28),
    );

    return ClipOval(
      child: Image.asset(
        avatarUrl.trim(),
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallbackAvatar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isVi = currentLang == 'vi';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.shade200, width: 1),
            ),
            child: Column(
              children: [
                const Icon(Icons.school, size: 54, color: Colors.deepOrange),
                const SizedBox(height: 10),
                const Text(
                  'ĐẠI HỌC PHENIKAA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isVi
                      ? 'Khoa Công nghệ Thông tin'
                      : 'Faculty of Information Technology',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            isVi ? 'Thành viên thực hiện đề tài' : 'Project Members',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: GroupData.members.length,
            itemBuilder: (ctx, index) {
              final member = GroupData.members[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: _buildMemberAvatar(member.avatarUrl),
                    title: Text(
                      member.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3),
                        Text(
                          'MSSV: ${member.studentId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  isVi ? 'Lập trình thiết bị di động' : 'Mobile Programming',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Giảng viên hướng dẫn: Thầy Nguyễn Xuân Quế',
                  style: TextStyle(fontSize: 13.5, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

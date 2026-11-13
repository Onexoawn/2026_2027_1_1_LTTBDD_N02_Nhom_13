class Member {
  final String name;
  final String studentId;
  final String avatarUrl;

  const Member({
    required this.name,
    required this.studentId,
    required this.avatarUrl,
  });
}

class GroupData {
  static const List<Member> members = [
    Member(
      name: 'Nguyễn Công Vinh',
      studentId: '24107963',
      avatarUrl: 'image/avatar/ncv.jpg',
    ),
  ];
}

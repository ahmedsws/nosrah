class Hashtag {
  final String text, key;
  final int priority;
  final bool isActive, hasCount;
  final int? count;

  const Hashtag({
    required this.text,
    required this.priority,
    required this.key,
    this.isActive = false,
    this.hasCount = false,
    this.count,
  });
}

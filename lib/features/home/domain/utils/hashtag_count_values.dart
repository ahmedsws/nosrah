class HashtagCountValues {
  late int franceBoycottDays;

  Map<String, int> getValues() {
    franceBoycottDays =
        DateTime.now().difference(DateTime(2020, 10, 27)).inDays;

    return {
      'france': franceBoycottDays,
    };
  }
}

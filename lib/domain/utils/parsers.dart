List<int> parseIntList(List<dynamic> data) {
  List<int> parsed = List<int>.empty(growable: true);
  data.forEach((element) {
    parsed.add(int.parse('$element'));
  });
  return parsed;
}

int parseInt(String id) {
  return int.parse(id);
}
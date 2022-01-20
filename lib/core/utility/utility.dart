Map<String, dynamic> toMap(dynamic d) =>
    Map<String, dynamic>.from(d as Map<dynamic, dynamic>);

List<Map<String, dynamic>> toList(dynamic d) =>
    List<Map<String, dynamic>>.from(d as Iterable<dynamic>);

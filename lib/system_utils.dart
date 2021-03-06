class SystemUtils {
  static List<String> expandEnvironmentVars(List<String> strings) {
    var list = [];
    var len = strings.length;
    for(var string in strings) {
      list.add(_expandMacro(string, (s) => Platform.environment[s]));
    }

    return list;
  }

  static String _expandMacro(String string, String callback(String)) {
    RegExp exp = const RegExp(@'({\S+?})');
    var matches = exp.allMatches(string);
    for(var match in matches) {
      var seq = match.group(0);
      var key = seq.substring(1, seq.length - 1);
      string = string.replaceAll(seq, callback(key));
    }

    return string;
  }
}

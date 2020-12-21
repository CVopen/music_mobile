// ignore: missing_return
import 'dart:math';

String computePlay(_num) {
  if (_num > 100000) {
    return _num.toString().substring(0, _num.toString().length - 5) + '万';
  }
  return _num.toString();
}

formatDuration(duration) {
  if (duration > 0) {
    int min = duration / 1000 ~/ 60;
    var sec = duration / 1000 % 60;
    sec = sec < 10 ? '0${sec ~/ 1}' : '${sec ~/ 1}';

    return "$min:$sec";
  }
  return '0:00';
}

// 生成随机数
List createArr(count, max, [arr]) {
  List result = [];
  if (arr == null) arr = [];
  result.addAll(arr);

  int countFor = count - result.length;

  for (var i = 0; i < countFor; i++) {
    result.add(Random().nextInt(max));
  }
  var dedu = Set();
  dedu.addAll(result);
  dedu.toList();

  if (dedu.length != count) {
    List rand = createArr(count, max, dedu.toList());
    dedu.addAll(rand);
  }
  return dedu.toList();
}

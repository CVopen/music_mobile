// ignore: missing_return
import 'dart:math';

String computePlay(_num) {
  if (_num > 100000) {
    return _num.toString().substring(0, _num.toString().length - 5) + '万';
  }
  return _num.toString();
}

// 生成随机数
createArr(count, max, [arr]) {
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

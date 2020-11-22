// ignore: missing_return
String computePlay(_num) {
  print('_num ${_num.toString().length}');
  if (_num > 100000) {
    return _num.toString().substring(0, _num.toString().length - 5) + '万';
  }
  return _num.toString();
}

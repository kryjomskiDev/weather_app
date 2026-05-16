import 'package:flutter_hooks/flutter_hooks.dart';

void useOnce(void Function() call, {List<Object> keys = const <Object>[]}) => useEffect(
  () {
    call();
    return;
  },
  keys,
);

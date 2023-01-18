typedef T InstanceGreator<T>();

class DependencyInjector {
  DependencyInjector._();

  static final _singleton = DependencyInjector._();

  factory DependencyInjector() => _singleton;

  final _instanceMap = Map<Type, _InstanceGenerator<Object>>();

  // register
  void register<T extends Object>(
    InstanceGreator<T> instance, {
    bool isSingleton = true,
  }) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  // get
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> instance ${T.toString()} not found.');
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceGreator<T> _instanceGreator;

  _InstanceGenerator(this._instanceGreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceGreator();
      _isFirstGet = false;
    }
    return _instance ?? _instanceGreator();
  }
}

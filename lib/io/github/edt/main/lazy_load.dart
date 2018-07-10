class LazyLoadedParameter<T> {
  bool _isLoaded = false;
  T _content;
  String _name;

  LazyLoadedParameter({String name}) : _name = name;

  get isLoaded {
    return _isLoaded;
  }

  get content {
    if (!this.isLoaded) return null;
    return _content;
  }

  get name => this._name;

  void update(T content) {
    this._content = content;
    this._isLoaded = true;
  }
}

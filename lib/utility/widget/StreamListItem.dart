import 'dart:async';

import 'package:flutter/widgets.dart';

class StreamListItem<T, S> extends StatefulWidget{

  final T initialData;
  final StreamListItemComparator<T, S> comparator;
  final StreamListItemBuilder<T> builder;
  final Stream<S> stream;

  StreamListItem({Key key, this.initialData, this.comparator, this.builder, this.stream}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StreamListItemState<T, S>();
  }
}


typedef StreamListItemBuilder<T> = Widget Function(BuildContext context, T data);
typedef StreamListItemComparator<T, S> = bool Function(T data, S changedObject);

class _StreamListItemState<T, S> extends State<StreamListItem<T, S>> {

  T _data;
  StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    this._data = widget.initialData;
    _subscribe();
  }

  @override
  void didUpdateWidget(StreamListItem<T, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      if (_subscription != null) {
        _unsubscribe();
      }
      _subscribe();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _data);
  }

  void _subscribe(){
    _subscription = widget.stream.listen((idObj){
      bool isSameObjId = widget.comparator(_data, idObj);
      if(isSameObjId){
        setState((){}); // Force update
      }
    });
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }
  }

}

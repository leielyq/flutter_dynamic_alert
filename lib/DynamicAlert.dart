import 'package:flutter/material.dart';

class DynamicAlert {
  static dynamic ctx;

  static var overlay;

  static void showCustomAlert(
      {BuildContext context,
      String title,
      String content,
      bool cancelable = true}) {
    overlay = _bulidOverlayEntry(title, cancelable, content, 0, () {
      overlay = _bulidOverlayEntry(title, cancelable, content, 1, () {});
      Overlay.of(context ?? ctx).insert(overlay);
    });
    Overlay.of(context ?? ctx).insert(overlay);
  }

  static OverlayEntry _bulidOverlayEntry(
      String title, bool cancelable, String content, int type, call) {
    var paths = ['question', 'error'];
    return OverlayEntry(builder: (BuildContext context) {
      return Material(
        color: Colors.grey.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: Card(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              title ?? '',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ),
                          Offstage(
                            offstage: !cancelable ?? true,
                            child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  overlay.remove();
                                }),
                          )
                        ],
                      ),
                      ImageIcon(
                        AssetImage('assets/alert/${paths[type]}.png'),
                        color: Colors.blue,
                        size: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        content ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          overlay.remove();
                          call();
                        },
                        color: Colors.blue,
                        child: Container(
                          width: 280,
                          alignment: Alignment.center,
                          child: Text(
                            '确定',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Offstage(
                        offstage: !cancelable ?? true,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('返回?'),
                            GestureDetector(
                              onTap: () {
                                overlay.remove();
                              },
                              child: Text(
                                '取消',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
//                Expanded(child: Text('123'))
          ],
        ),
      );
    });
  }
}

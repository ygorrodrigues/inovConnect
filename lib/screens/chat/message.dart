import 'package:flutter/material.dart';

class Message extends StatelessWidget {

  Message({
    this.message,
    this.me,
    this.time,
  });
  final String message;
  final bool me;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: me
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
      children: <Widget> [
        Container(
          child: Padding(
            padding: me ?
              const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0) :
              const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: me 
                  ? Colors.white
                  : Colors.grey[200],
                borderRadius: me
                  ? BorderRadius.only(
                    topLeft: const Radius.circular(5),
                    topRight: const Radius.circular(5),
                    bottomLeft: const Radius.circular(5),
                  ) 
                  : BorderRadius.only(
                    topLeft: const Radius.circular(5),
                    topRight: const Radius.circular(5),
                    bottomRight: const Radius.circular(5),
                  ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 5, 5),
                    child: Text(
                      _timeFormat(time),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

  String _timeFormat(String time) {
    int start = time.indexOf('T') + 1;
    return time.substring(start, start + 5);
  }
}
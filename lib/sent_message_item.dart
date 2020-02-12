import 'package:flutter/material.dart';

class SentMessageItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height-200,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 150.0),
                Container(
                  width: MediaQuery.of(context).size.width-150,
                  padding: EdgeInsets.fromLTRB(20, 15, 10, 10),
                  color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Text('I have a problem with the stc lavatories',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('9:25 am.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
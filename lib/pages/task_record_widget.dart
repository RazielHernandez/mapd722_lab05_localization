import 'package:flutter/material.dart';

class TaskRecordWidget extends StatelessWidget {
  final String id;
  final String title;
  final bool isDone;
  final void Function(String) onCompleteTask;

  const TaskRecordWidget(this.id, this.title, this.isDone, this.onCompleteTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),*/
        elevation: 4,
        margin: EdgeInsets.all(5),
        child: Row(children: [
          Stack(
            children: [
              const ClipRRect(
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Switch(
                value: isDone,
                onChanged: ((value) => {
                  onCompleteTask(id)
              }))
              /*Text(
                'isDone :$isDone',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )*/
            ],
          )
        ]),
      ),
    );
  }
}
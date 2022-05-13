import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';

class DeleteTodoDialog extends Dialog {
  final Todo todo;

  const DeleteTodoDialog({Key? key, required this.todo}) : super(key: key);

  _dismissDialog(BuildContext context, bool delete) {
    Navigator.of(context).pop(delete);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dismissDialog(context, false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _createTitleWidget(context, todo.title!),
                          _createDescWidget(todo.description!),
                        ],
                      ),
                    ),
                    _createOperationWidget(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createTitleWidget(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7.5)),
            color: Color.fromARGB(255, 80, 210, 194),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: const TextStyle(
              color: Color.fromARGB(255, 74, 74, 74),
              fontSize: 18,
              fontFamily: 'Avenir',
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              height: 1,
              color: const Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        )
      ],
    );
  }

  Widget _createDescWidget(String desc) {
    return Text(
      desc,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
    );
  }

  Widget _createOperationWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _dismissDialog(context, false);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: const Color.fromARGB(255, 221, 221, 221),
              child: const Text(
                '取消',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _dismissDialog(context, true);
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              color: const Color.fromARGB(255, 255, 92, 92),
              child: const Text(
                '删除',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

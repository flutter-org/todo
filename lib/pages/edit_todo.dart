import 'package:flutter/material.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/model/todo.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late OpenType _openType;
  late Todo _todo;
  late Map<OpenType, _OpenTypeConfig> _openTypeConfigMap;

  @override
  void initState() {
    super.initState();
    _openTypeConfigMap = {
      OpenType.Preview: _OpenTypeConfig('查看 TODO', Icons.edit, _edit),
      OpenType.Edit: _OpenTypeConfig('编辑 TODO', Icons.edit, _submit),
      OpenType.Add: _OpenTypeConfig('添加 TODO', Icons.edit, _submit),
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EditTodoPageArgument? arguments = ModalRoute.of(context)?.settings.arguments as EditTodoPageArgument;
    _openType = arguments.openType;
    _todo = arguments?.todo ?? Todo();
  }

  void _edit() {
    setState(() {
      _openType = OpenType.Edit;
    });
  }

  void _submit() {
    Navigator.of(context).pop();
  }

  Widget _buildForm() {
    return Center(child: Text(_openType.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_openTypeConfigMap[_openType]!.title),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _openTypeConfigMap[_openType]!.icon,
              color: Colors.black87,
            ),
            onPressed: () {
              _openTypeConfigMap[_openType]!.onPressed();
            },
          )
        ],
      ),
      body: _buildForm(),
    );
  }
}

class _OpenTypeConfig {
  final String title;
  final IconData icon;
  final Function onPressed;

  const _OpenTypeConfig(this.title, this.icon, this.onPressed);
}

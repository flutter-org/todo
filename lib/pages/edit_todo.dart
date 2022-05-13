import 'package:flutter/material.dart';
import 'package:todo/component/label_group.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/model/todo.dart';

const TextStyle _labelTextStyle = TextStyle(
  color: Color(0xFF1D1D26),
  fontFamily: 'Avenir',
  fontSize: 14.0,
);
const EdgeInsets _labelPadding = EdgeInsets.fromLTRB(20, 10, 20, 20);
const InputBorder _textFormBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black26,
    width: 0.5,
  ),
);

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late OpenType _openType;
  late Todo _todo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    // validate 方法会触发 Form 组件中所有 TextFormField 的 validator 方法
    if (_formKey.currentState!.validate()) {
      // 同样, save 方法会触发 Form 组件中所有 TextFormField 的 onSave 方法
      _formKey.currentState!.save();
      Navigator.of(context).pop();
    }
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

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            _buildTextFormField(
              '名称',
              '任务名称',
              maxLines: 1,
              initialValue: _todo.title,
              onSaved: (value) => _todo.title = value,
            ),
            _buildTextFormField(
              '描述',
              '任务描述',
              initialValue: _todo.description,
              onSaved: (value) => _todo.description = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    String title,
    String hintText, {
    int? maxLines,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
  }) {
    TextInputType inputType = maxLines == null ? TextInputType.multiline : TextInputType.text;
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: TextFormField(
        keyboardType: inputType,
        validator: (String? value) {
          return (value != null && value!.isNotEmpty) ? null : '$title 不能为空';
        },
        onSaved: onSaved,
        textInputAction: TextInputAction.done,
        maxLines: maxLines,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: _textFormBorder,
        ),
      ),
    );
  }
}

class _OpenTypeConfig {
  final String title;
  final IconData icon;
  final Function onPressed;

  const _OpenTypeConfig(this.title, this.icon, this.onPressed);
}

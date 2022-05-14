import 'package:flutter/material.dart';
import 'package:todo/component/date_field_group.dart';
import 'package:todo/component/label_group.dart';
import 'package:todo/component/location_field_group.dart';
import 'package:todo/component/priority_field_group.dart';
import 'package:todo/component/time_field_group.dart';
import 'package:todo/const/route_argument.dart';
import 'package:todo/const/route_url.dart';
import 'package:todo/extension/date_time.dart';
import 'package:todo/extension/time_of_day.dart';
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

  final TextEditingController _dateTextEditingController = TextEditingController();
  final TextEditingController _startTimeEditingController = TextEditingController();
  final TextEditingController _endTimeEditingController = TextEditingController();
  final TextEditingController _locationEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _openTypeConfigMap = {
      OpenType.Preview: _OpenTypeConfig('查看 TODO', Icons.edit, _edit),
      OpenType.Edit: _OpenTypeConfig('编辑 TODO', Icons.check, _submit),
      OpenType.Add: _OpenTypeConfig('添加 TODO', Icons.check, _submit),
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EditTodoPageArgument? arguments = ModalRoute.of(context)?.settings.arguments as EditTodoPageArgument;
    _openType = arguments.openType;
    _todo = arguments.todo ?? Todo();
    _dateTextEditingController.text = _todo.date!.dateString;
    _startTimeEditingController.text = _todo.startTime!.timeString;
    _endTimeEditingController.text = _todo.endTime!.timeString;
    _locationEditingController.text = _todo.location.description;
  }

  @override
  void dispose() {
    super.dispose();
    _dateTextEditingController.dispose();
    _startTimeEditingController.dispose();
    _endTimeEditingController.dispose();
    _locationEditingController.dispose();
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
    bool canEdit = _openType != OpenType.Preview;
    return SingleChildScrollView(
      child: IgnorePointer(
        ignoring: !canEdit,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
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
                _buildDateFormField(
                  '日期',
                  '请选择日期',
                  initialValue: _todo.date!,
                  controller: _dateTextEditingController,
                  onSelect: (value) {
                    _todo.date == value.dayTime;
                    _dateTextEditingController.text = _todo.date!.dateString;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildTimeFormField(
                        '开始时间',
                        '请选择开始时间',
                        initialValue: _todo.startTime!,
                        controller: _startTimeEditingController,
                        onSelect: (value) {
                          _todo.startTime = value;
                          _startTimeEditingController.text = _todo.startTime!.timeString;
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildTimeFormField(
                        '终止时间',
                        '请选择终止时间',
                        initialValue: _todo.endTime!,
                        controller: _endTimeEditingController,
                        onSelect: (value) {
                          _todo.endTime = value;
                          _endTimeEditingController.text = _todo.endTime!.timeString;
                        },
                      ),
                    ),
                  ],
                ),
                _buildPriorityFormField('优先级'),
                _buildLocationFormField(
                  '位置',
                  '点击以保存当前位置',
                  controller: _locationEditingController,
                  onSaved: (Location location) {
                    _todo.location = location;
                    _locationEditingController.text = location.description;
                  },
                ),
              ],
            ),
          ),
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
          return (value != null && value.isNotEmpty) ? null : '$title 不能为空';
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

  Widget _buildDateFormField(
    String title,
    String hintText, {
    required DateTime initialValue,
    TextEditingController? controller,
    Function(DateTime)? onSelect,
  }) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: DateFieldGroup(
        onSelect: onSelect,
        initialDate: initialValue,
        startDate: initialValue,
        endDate: DateTime(2025),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText, disabledBorder: _textFormBorder),
          validator: (String? value) {
            return value == null ? '$title 不能为空' : null;
          },
        ),
      ),
    );
  }

  Widget _buildTimeFormField(
    String title,
    String hintText, {
    TextEditingController? controller,
    required TimeOfDay initialValue,
    Function(TimeOfDay)? onSelect,
  }) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: TimeFieldGroup(
        onSelect: onSelect,
        initialTime: initialValue,
        child: TextFormField(
          validator: (String? value) {
            return (value != null && value.isNotEmpty) ? null : '$title 不能为空';
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            disabledBorder: _textFormBorder,
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityFormField(String title) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: PriorityFieldGroup(
        initialValue: _todo.priority,
        onChange: (Priority priority) {
          setState(() {
            _todo.priority = priority;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_todo.priority.description),
                  Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 5,
                      color: _todo.priority.color,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationFormField(
    String title,
    String hintText, {
    TextEditingController? controller,
    Function(Location)? onSaved,
  }) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: GestureDetector(
        onLongPress: () {
          Navigator.of(context).pushNamed(
            LOCATION_DETAIL_PAGE_URL,
            arguments: LocationDetailArgument(_todo.location),
          );
        },
        child: LocationFieldGroup(
          onChange: onSaved,
          child: TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: _textFormBorder,
            ),
          ),
        ),
      ),
    );
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
}

class _OpenTypeConfig {
  final String title;
  final IconData icon;
  final Function onPressed;

  const _OpenTypeConfig(this.title, this.icon, this.onPressed);
}

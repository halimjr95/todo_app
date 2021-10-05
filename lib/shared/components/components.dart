import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  color: color,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      '${text}',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);


Widget DefaultFormFied({
  required TextInputType type,
  required TextEditingController controller,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChange

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  validator: validate,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  onChanged: onChange,
  decoration: InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: label,
    border: OutlineInputBorder(),
  ),
);


Widget DefaultTaskTemp(context, Map model) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.blue,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateDatebase(
                id: model['id'],
                status: 'done'
            );
          },
          icon: Icon(
            Icons.check_box,
            color: Colors.green,
          ),

        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateDatebase(
                id: model['id'],
                status: 'archive',
            );
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),

        ),
      ],
    ),
  ),
  onDismissed:(direction)
  {
    AppCubit.get(context).deleteDatebase(id: model['id']);
  },
);
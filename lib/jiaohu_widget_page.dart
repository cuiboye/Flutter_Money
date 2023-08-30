import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/utils/toast_utils.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

enum SingingCharacter { lafayette, jefferson }

class JiaohuWidgetPage extends StatefulWidget {
  const JiaohuWidgetPage({super.key});

  @override
  State<JiaohuWidgetPage> createState() => _JiaohuWidgetPageState();
}

class _JiaohuWidgetPageState extends State<JiaohuWidgetPage> {
  bool isChecked = false;
  SingingCharacter? _character = SingingCharacter.lafayette;
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: '交互式Widget',),
      body: Column(
        children: [
          Text('1）系统的CheckBox，无法自定义'),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Text('2）可自定义的CheckBox'),
          RoundCheckBox(
            onTap: (selected) {},
            checkedWidget: const Icon(Icons.mood, color: Colors.white),
            uncheckedWidget: const Icon(Icons.mood_bad),
            animationDuration: const Duration(
              seconds: 1,
            ),
          ),
          Text('3）TextButton'),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: ()=>ToastUtils.showToast('点击了文字'),
            child: const Text('Disabled'),
          ),
          Text('4）IconButton'),
          IconButton(
            icon: const Icon(Icons.volume_up),
            tooltip: 'Increase volume by 10',
            onPressed: () {

            },
          ),
          Text('5）Radio'),
          ListTile(
            title: const Text('Lafayette'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.lafayette,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Thomas Jefferson'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.jefferson,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          Text('6）Switch开关'),
          Switch(
            // This bool value toggles the switch.
            value: light,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                light = value;
              });
            },
          )
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
}


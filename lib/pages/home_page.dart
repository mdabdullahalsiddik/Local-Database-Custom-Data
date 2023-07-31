import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_costom_data/models/student_model.dart';
import 'package:hive_costom_data/static/all_icons.dart';
import 'package:hive_costom_data/static/all_text.dart';
import 'package:hive_costom_data/static/color.dart';
import 'package:hive_costom_data/widgets/costom_textfield.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController deparmentController = TextEditingController();

  late Box studentBox;
  @override
  void initState() {
    studentBox = Hive.box("Student");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AllColors.blueGreyColor,
          title: AllTexts.appbarText,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AllColors.blueGreyColor,
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: AlertDialog(
                    title: AllTexts.saveText,
                    actions: [
                      SizedBox(height: 10.0),
                      CostomTextField(
                          controller: nameController, hintText: "Name"),
                      SizedBox(height: 10.0),
                      CostomTextField(
                          controller: rollController, hintText: "Roll"),
                      SizedBox(height: 10.0),
                      CostomTextField(
                          controller: deparmentController,
                          hintText: "Deparment"),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AllColors.blueGreyColor)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: AllTexts.noText),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AllColors.blueGreyColor)),
                              onPressed: () {
                                studentBox.add(StudentModel(
                                    name: nameController.text,
                                    roll: rollController.text,
                                    deparment: deparmentController.text));
                                nameController.clear();
                                rollController.clear();
                                deparmentController.clear();
                                Navigator.pop(context);
                              },
                              child: AllTexts.okText),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: AllIcons.addIcon,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box("Student").listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: studentBox.keys.length,
              itemBuilder: (context, index) {
                StudentModel item = studentBox.getAt(index);
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    tileColor: AllColors.blueGreyColor,
                    leading: Text(item.deparment.toString()),
                    title: Text(item.name.toString()),
                    subtitle: Text(item.roll.toString()),
                    trailing: SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      child: AlertDialog(
                                        title: AllTexts.updateText,
                                        actions: [
                                          SizedBox(height: 10.0),
                                          CostomTextField(
                                              controller: nameController,
                                              hintText: "Name"),
                                          SizedBox(height: 10.0),
                                          CostomTextField(
                                              controller: rollController,
                                              hintText: "Roll"),
                                          SizedBox(height: 10.0),
                                          CostomTextField(
                                              controller: deparmentController,
                                              hintText: "Deparment"),
                                          SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              AllColors
                                                                  .blueGreyColor)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: AllTexts.noText),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              AllColors
                                                                  .blueGreyColor)),
                                                  onPressed: () {
                                                    //  StudentModel item = studentBox.get(index);
                                                    studentBox.putAt(
                                                        index,
                                                        StudentModel(
                                                            name: nameController
                                                                    .text
                                                                    .isEmpty
                                                                ? item.name
                                                                    .toString()
                                                                : nameController
                                                                    .text,
                                                            roll: rollController
                                                                    .text
                                                                    .isEmpty
                                                                ? item.roll
                                                                    .toString()
                                                                : rollController
                                                                    .text,
                                                            deparment: deparmentController
                                                                    .text
                                                                    .isEmpty
                                                                ? item.deparment
                                                                    .toString()
                                                                : deparmentController
                                                                    .text));
                                                    nameController.clear();
                                                    rollController.clear();
                                                    deparmentController.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: AllTexts.okText),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: AllIcons.editIcon),
                          SizedBox(width: 20),
                          InkWell(
                              onTap: () {
                                studentBox.deleteAt(index);
                              },
                              child: AllIcons.deleteIcon),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

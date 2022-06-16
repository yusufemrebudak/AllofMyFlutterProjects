import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_app/data/local_storage_data_abs.dart';
import 'package:flutter_todo_app/helper/translation_helper.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/widgets/custom_search_delegate.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  late LocalStorage _localStorage;
  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allTasks = <Task>[];
    _getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: GestureDetector(
            onTap: () => _showAddTaskBottomSheet(),
            child: const  Text(
              "title",
              style: TextStyle(
                color: Colors.black,
              ),
            ).tr(),
          ),
          centerTitle: false, // en baştan başlaması için
          actions: [
            IconButton(
                onPressed: () {
                  _showSearchPage();
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  _showAddTaskBottomSheet();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: _allTasks.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  var _oAnkiListeElemani = _allTasks[index];
                  return Dismissible(
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          const Text("remove_task").tr()
                        ],
                      ),
                      key: Key(_oAnkiListeElemani.id),
                      onDismissed: (direction) {
                        _allTasks.removeAt(index);
                        _localStorage.deleteTask(task: _oAnkiListeElemani);
                        setState(() {});
                      },
                      child: TaskItem(
                        task: _oAnkiListeElemani,
                      ));
                },
                itemCount: _allTasks.length,
              )
            :  Center(
                child: const Text("empty_task_list").tr(),
              ));
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            //color: Colors.black,

            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom), //padding içindeki elemanlara göre yani burada listtile ile arasında mesaje bırakacak
            width: MediaQuery.of(context).size.width,

            child: ListTile(
              title: TextField(
                autofocus: true,
                style: const TextStyle(fontSize: 20),
                decoration:  InputDecoration(
                    hintText: 'add_task'.tr(), border: InputBorder.none),
                onSubmitted: (value) {
                  Navigator.of(context).pop();
                  if (value.length > 3) {
                    DatePicker.showTimePicker(context, showSecondsColumn: false,
                    locale: Translationhelper.getDeviceLanguage(context),
                        onConfirm: (time) async {
                      var yeniEklenecekGorev =
                          Task.create(name: value, createdAt: time);
                      _allTasks.insert(0, yeniEklenecekGorev);
                      await _localStorage.addTask(task: yeniEklenecekGorev);
                      setState(() {});
                    });
                  }
                },
              ),
            ),
          );
        }); // Bu küçük bir pencerede açar.
  }

  void _getAllTaskFromDb() async {
    _allTasks = await _localStorage.getAllTasks();
    setState(() {});
  }

  void _showSearchPage() async {
    print("girdi");
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allTasks: _allTasks));
            print("girdi");

    _getAllTaskFromDb();
        

  }

  /////////////////// BİTİŞ
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage_data_abs.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';

import '../models/task_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});
  // kurucu yukarıdaki satır
  @override
  List<Widget>? buildActions(BuildContext context) {
    // arama kısmının sağ tarafındaki ikonları
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // en baştaki ikonları belirtiyor
    return GestureDetector(
        onTap: () {
          close(context, null);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.red,
          size: 20,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // arama yaptıkran sonra  çıkacak olan sonuçları nasıl göstereceğimizi
    //
    List<Task> filteredList = allTasks
        .where(
            (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              var _oAnkiListeElemani = filteredList[index];
              return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text('remove_task').tr()
                    ],
                  ),
                  key: Key(_oAnkiListeElemani.id),
                  onDismissed: (direction) async {
                    filteredList.removeAt(index);
                    await locator<LocalStorage>()
                        .deleteTask(task: _oAnkiListeElemani);
                  },
                  child: TaskItem(
                    task: _oAnkiListeElemani,
                  ));
            },
            itemCount: filteredList.length,
          )
        : Center(
            child: Text("search_not_found").tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //1-2 harf veya hiçbişey yazmadığında görünmesini istediğimiz şeyleri yazacağız.
    return Container();
  }
}

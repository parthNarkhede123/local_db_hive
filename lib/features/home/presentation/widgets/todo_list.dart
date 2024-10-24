import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_db/features/home/data/models/get_data_response.dart';
import 'package:local_db/features/home/presentation/bloc/bloc.dart';

class ListWidget extends StatelessWidget {
  final GetData getData;
  const ListWidget({super.key, required this.getData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: getData.todos?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                getData.todos?[index].todo ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: getData.todos?[index].completed ?? false
                      ? Colors.grey
                      : Colors.black,
                  decoration: getData.todos?[index].completed ?? false
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              trailing: Checkbox(
                value: getData.todos?[index].completed,
                onChanged: (bool? value) {
                  BlocProvider.of<HomeBloc>(context).add(ToDoPutEvent(
                      id: getData.todos?[index].id ?? 0,
                      isComplete: getData.todos?[index].completed ?? false));
                },
                activeColor: Colors.green,
              ),
            ),
          );
        },
      ),
    );
  }
}

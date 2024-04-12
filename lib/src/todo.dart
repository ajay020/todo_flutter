import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<StatefulWidget> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _list = [];

  void _editTask(int index) async {
    String editedTask = await showDialog(
      context: context,
      builder: (context) {
        String currentTask = _list[index];
        TextEditingController controller =
            TextEditingController(text: currentTask);

        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter the edited task',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (editedTask.isNotEmpty) {
      setState(() {
        _list[index] = editedTask;
      });
    }
  }

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: _list.length,
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.red,
                thickness: 2.0,
                height: 0.0, // adjust the height of the divider
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.white,
                title: Text(
                  _list[index],
                ),
                trailing: Container(
                  color: Colors.amber,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          setState(() {
                            _list.removeAt(index);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          _editTask(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.only(bottom: 28.0),
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Add a task...',
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurple,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _list.add(_controller.text);
                      _controller.text = "";
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

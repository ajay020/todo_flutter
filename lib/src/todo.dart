import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<StatefulWidget> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController _controller = TextEditingController();
  final List<Task> _list = [];

  void _editTask(int index) async {
    String editedTask = await showDialog(
      context: context,
      builder: (context) {
        String currentTask = _list[index].text;
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
        _list[index].text = editedTask;
      });
    }
  }

  @override
  Widget build(Object context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Checkbox(
                        value: _list[index].completed,
                        onChanged: (val) {
                          setState(() {
                            _list[index].completed = !_list[index].completed;
                          });
                        }),
                    tileColor: Colors.white,
                    title: Text(
                      _list[index].text,
                      style: TextStyle(
                        fontSize: 18.0,
                        decoration: _list[index].completed
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Text color of the title
                      ),
                    ),
                    trailing: Row(
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
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          margin: const EdgeInsets.only(bottom: 28.0),
          color: Colors.grey[100],
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
                color: Colors.blue,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _list.add(Task(_controller.text, completed: false));
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

class Task {
  String text;
  bool completed;

  Task(this.text, {this.completed = false});
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> resumes = [];
  String? selectedResume;

  Future<void> _addResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        resumes.add(result.files.single.name);
      });
    }
  }

  void _deleteResume(int index) {
    setState(() {
      if (selectedResume == resumes[index]) {
        selectedResume = null;
      }
      resumes.removeAt(index);
    });
  }

  void _selectResume(int index) {
    setState(() {
      selectedResume = resumes[index];
    });
  }

  void _applyWithResume(String specialization) {
    if (selectedResume == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите резюме')),
      );
      return;
    }

    // Здесь логика отправки отклика
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Отклик с резюме $selectedResume отправлен на $specialization')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addResume,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Мои резюме',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: resumes.isEmpty
                  ? const Center(child: Text('Нет добавленных резюме'))
                  : ListView.builder(
                itemCount: resumes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.description),
                      title: Text(resumes[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteResume(index),
                          ),
                          Checkbox(
                            value: selectedResume == resumes[index],
                            onChanged: (_) => _selectResume(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (resumes.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Выбранное резюме для откликов:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                selectedResume ?? 'Не выбрано',
                style: TextStyle(
                  color: selectedResume != null ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _showSpecializationsDialog(),
                child: const Text('Быстрый отклик'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSpecializationsDialog() {
    final specializations = [
      'Проектирование зданий',
      'Системы автоматизации',
      'Видеонаблюдение',
      'Инженерные сети'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите специализацию'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: specializations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(specializations[index]),
                  onTap: () {
                    Navigator.pop(context);
                    _applyWithResume(specializations[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
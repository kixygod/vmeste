import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: viewModel.selectedImage != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(viewModel.selectedImage!),
                    )
                  : DecoratedBox(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/images/person.png', width: 120, height: 120),
                    ),
            ),
            const SizedBox(height: 16),
            // Кнопка для выбора изображения
            ElevatedButton(
              onPressed: viewModel.selectImage,
              child: const Text('Выбрать изображение'),
            ),
            const SizedBox(height: 16),
            // Поле для ввода имени
            TextField(
              decoration: const InputDecoration(labelText: 'Имя'),
              onChanged: viewModel.updateFirstName,
            ),
            const SizedBox(height: 16),
            // Поле для ввода фамилии
            TextField(
              decoration: const InputDecoration(labelText: 'Фамилия'),
              onChanged: viewModel.updateLastName,
            ),
            const SizedBox(height: 16),
            // Поле для выбора города
            TextField(
              decoration: const InputDecoration(labelText: 'Город'),
              onChanged: viewModel.updateCity,
            ),
            const SizedBox(height: 16),
            // Кнопка для сохранения изменений
            ElevatedButton(
              onPressed: viewModel.saveSettings,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}

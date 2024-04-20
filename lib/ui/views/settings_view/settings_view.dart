import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vmeste/resources/images.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
            // Предпросмотр изображения или стандартное изображение "person"
            viewModel.selectedImage != null
                ? Image.file(
                    viewModel.selectedImage!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Image.asset(Images.person, width: 120, height: 120),
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

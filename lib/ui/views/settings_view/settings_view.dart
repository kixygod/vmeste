import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'), // Заголовок AppBar
      ),
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
                : Image.asset(
                    'assets/images/person.jpg', // Путь к стандартному изображению "person"
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),
            // Кнопка для выбора изображения
            ElevatedButton(
              onPressed: viewModel.selectImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16),
            // Поле для ввода имени
            TextField(
              decoration: const InputDecoration(labelText: 'First Name'),
              onChanged: viewModel.updateFirstName,
            ),
            const SizedBox(height: 16),
            // Поле для ввода фамилии
            TextField(
              decoration: const InputDecoration(labelText: 'Last Name'),
              onChanged: viewModel.updateLastName,
            ),
            const SizedBox(height: 16),
            // Поле для выбора страны
            TextField(
              decoration: const InputDecoration(labelText: 'Country'),
              onChanged: viewModel.updateCountry,
            ),
            const SizedBox(height: 16),
            // Поле для выбора города
            TextField(
              decoration: const InputDecoration(labelText: 'City'),
              onChanged: viewModel.updateCity,
            ),
            const SizedBox(height: 16),
            // Кнопка для сохранения изменений
            ElevatedButton(
              onPressed: viewModel.saveSettings,
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

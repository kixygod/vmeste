import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
            ElevatedButton(
              onPressed: viewModel.selectImage,
              child: const Text('Выбрать изображение'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Город'),
              onChanged: viewModel.updateCity,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Дата рождения (дд.мм.гггг)'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: viewModel.updateBirthDate,
            ),
            const SizedBox(height: 16),
            // Выпадающее меню для выбора пола
            DropdownButtonFormField<Gender>(
              decoration: const InputDecoration(labelText: 'Пол'),
              value: viewModel.gender,
              onChanged: viewModel.updateGender,
              items: const [
                DropdownMenuItem(
                  value: Gender.male,
                  child: Text('Мужской'),
                ),
                DropdownMenuItem(
                  value: Gender.female,
                  child: Text('Женский'),
                ),
              ],
            ),
            const SizedBox(height: 16),
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

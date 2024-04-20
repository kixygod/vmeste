import 'package:VMeste/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:VMeste/ui/theme/colors.dart';
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
                      child:
                          Image.asset(Images.person, width: 120, height: 120),
                    ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.green,
                padding: const EdgeInsets.all(16.0),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: viewModel.selectImage,
              child: Text(
                'Выбрать изображение',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Город',
                labelStyle: TextStyle(color: AppColors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkPurple),
                ),
              ),
              onChanged: viewModel.updateTown,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Ссылка на вк или телеграмм',
                labelStyle: TextStyle(color: AppColors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkPurple),
                ),
              ),
              onChanged: viewModel.updateContact,
            ),
            const SizedBox(height: 20),
            viewModel.isLoading
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.darkPurple,
                      padding: const EdgeInsets.all(10.0),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: null, // Деактивируем кнопку во время загрузки
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.darkPurple,
                      padding: const EdgeInsets.all(16.0),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: viewModel.saveSettings,
                    child: Text(
                      'Сохранить',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

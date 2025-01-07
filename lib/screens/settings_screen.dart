import 'package:flutter/material.dart';
import 'package:nice_village/Localization/app_localizations.dart';
import 'package:nice_village/providers/localization.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get translations using the translate method
    final welcomeText =
        AppLocalizations.of(context)?.translate('welcome') ?? 'Welcome';
    final settingsText =
        AppLocalizations.of(context)?.translate('settings') ?? 'Settings';
    final changeLangText =
        AppLocalizations.of(context)?.translate('change_language') ??
            'Change Language';

    return Scaffold(
      appBar: AppBar(
        title: Text(settingsText),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(welcomeText,
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          ListTile(
            title: Text(changeLangText),
            trailing: PopupMenuButton<String>(
              onSelected: (String value) {
                // Change language using the provider
                Provider.of<LocaleProvider>(context, listen: false)
                    .setLocale(Locale(value));
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: 'ar',
                  child: Text('العربية'),
                ),
                const PopupMenuItem(
                  value: 'fa',
                  child: Text('کوردی'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example of using translations in any other widget file
// lib/widgets/custom_button.dart

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get translated text for the button
    final saveText = AppLocalizations.of(context)?.translate('save') ?? 'Save';

    return ElevatedButton(
      onPressed: () {
        // Button action
      },
      child: Text(saveText),
    );
  }
}

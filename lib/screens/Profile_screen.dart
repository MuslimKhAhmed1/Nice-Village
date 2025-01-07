import 'package:flutter/material.dart';
import 'package:nice_village/config/themes.dart';
import 'package:nice_village/providers/localization.dart';
import 'package:provider/provider.dart';
import 'package:nice_village/Localization/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          // Custom app bar with profile info
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            decoration: BoxDecoration(
              color: theme.primaryColor, // Using theme primary color
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      AppLocalizations.of(context)?.translate('profile') ??
                          'Profile',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)?.translate('user_name') ??
                      'User name',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context)?.translate('villa_number') ?? 'Villa number'} 22',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    'my_posts',
                    Icons.article_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MyPostsPage()),
                    ),
                  ),
                  _buildMenuItem(
                    context,
                    'change_password',
                    Icons.lock_outline,
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    'notification_alert',
                    Icons.notifications_none,
                    isSwitch: true,
                  ),
                  _buildMenuItem(
                    context,
                    'dark_mode',
                    Icons.dark_mode_outlined,
                    isSwitch: true,
                    switchValue: themeProvider.isDarkMode,
                    onSwitchChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                  _buildMenuItem(
                    context,
                    'languages',
                    Icons.language,
                    onTap: () => _showLanguageDialog(context),
                  ),
                  const Spacer(),
                  _buildMenuItem(
                    context,
                    'logout',
                    Icons.logout,
                    onTap: () => _showLogoutDialog(context),
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String titleKey,
    IconData icon, {
    VoidCallback? onTap,
    bool isSwitch = false,
    bool switchValue = false,
    Function(bool)? onSwitchChanged,
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          onTap: isSwitch ? null : onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          leading: Icon(icon, color: theme.listTileTheme.textColor),
          title: Text(
            AppLocalizations.of(context)?.translate(titleKey) ?? titleKey,
            style: theme.textTheme.titleMedium,
          ),
          trailing: isSwitch
              ? Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: theme.primaryColor,
                )
              : onTap != null
                  ? Icon(Icons.arrow_forward_ios,
                      size: 16, color: theme.listTileTheme.textColor)
                  : null,
        ),
        if (showDivider) Divider(height: 1, color: theme.dividerColor),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)?.translate('logout_title') ?? 'Logout',
          style: theme.textTheme.titleLarge,
        ),
        content: Text(
          AppLocalizations.of(context)?.translate('logout_message') ??
              'Are you sure you want to logout?',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)?.translate('cancel') ?? 'Cancel',
              style: theme.textTheme.labelLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)?.translate('logout') ?? 'Logout',
              style: theme.textTheme.labelLarge?.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context)?.translate('select_language') ??
                'Select Language',
            style: theme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English', style: theme.textTheme.titleMedium),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('کوردی', style: theme.textTheme.titleMedium),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('fa'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('العربية', style: theme.textTheme.titleMedium),
                onTap: () {
                  Provider.of<LocaleProvider>(context, listen: false)
                      .setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyPostsPage extends StatelessWidget {
  const MyPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.translate('my_posts') ?? 'My Posts',
          style: theme.appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: theme.appBarTheme.titleTextStyle?.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            color: theme.cardColor,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                    ?.translate('user_name') ??
                                'User Name',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            'Dec ${20 + index}, 2024',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)
                            ?.translate('sample_post_content') ??
                        'This is a sample post content. It can contain multiple lines of text and other information relevant to the post.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

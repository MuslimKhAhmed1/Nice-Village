import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

class DetailInfoGuest extends StatelessWidget {
  const DetailInfoGuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Property Image
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // App Bar with back and search buttons
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Type and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          AppLocalizations.of(context)?.translate('villa') ??
                              'Villa',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Text(
                        'Price: 1000\$',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)
                                ?.translate('location_text') ??
                            'Green Estate, Lagos, Island',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Property Features
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeature(context, Icons.bed, '4', 'Beds'),
                      _buildFeature(context, Icons.bathtub, '2', 'Baths'),
                      _buildFeature(context, Icons.kitchen, '1', 'Kitchen'),
                      _buildFeature(context, Icons.wifi, 'Wifi', ''),
                      _buildFeature(
                          context, Icons.square_foot, '1,384', 'sqft'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Owner Information
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/avatar.png'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                    ?.translate('owner_name') ??
                                'Adebeyo Nyiyi',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            AppLocalizations.of(context)?.translate('owner') ??
                                'Owner',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _buildContactButton(
                              context, Icons.message, Colors.blue.shade100),
                          const SizedBox(width: 8),
                          _buildContactButton(
                              context, Icons.phone, Colors.blue.shade100),
                          const SizedBox(width: 8),
                          _buildContactButton(
                              context, Icons.mail, Colors.blue.shade100),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Overview Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.translate('overview') ??
                            'Overview',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)
                                  ?.translate('read_more') ??
                              'Read More',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)
                            ?.translate('property_description') ??
                        'Luxury 5 Bedrooms full detached for sales amenties: fitted kitchen with accessories',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(
      BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        if (label.isNotEmpty)
          Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildContactButton(BuildContext context, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: Colors.blue),
    );
  }
}

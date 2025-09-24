import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color: colors.surfaceContainerHighest,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: colors.primaryContainer),
            accountName: Text('Edahi Avila', style: TextStyle(color: colors.onPrimaryContainer, fontWeight: FontWeight.w600)),
            accountEmail: Text('edahi@eventos.com', style: TextStyle(color: colors.onPrimaryContainer.withOpacity(0.9))),
            currentAccountPicture: CircleAvatar(
              backgroundColor: colors.primary,
              child: ClipOval(
                child: Image.network(
                  'https://avatarfiles.alphacoders.com/375/375938.png',
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                  errorBuilder: (context, error, stackTrace) => Center(child: Text('PE', style: TextStyle(color: colors.onPrimary, fontWeight: FontWeight.bold))),
                ),
              ),
            ),
          ),
            ListTile(
              leading: Icon(Icons.event, color: colors.primary),
              title: Text('Eventos', style: TextStyle(color: colors.onSurface)),
              onTap: () {
                final isPhone = MediaQuery.of(context).size.shortestSide < 600;
                if (isPhone) Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}

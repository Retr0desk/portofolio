import 'package:flutter/material.dart';
import 'glass.dart';

class FancyNavBar extends StatelessWidget {
  final VoidCallback? onAbout;
  final VoidCallback? onSkills;
  final VoidCallback? onProjects;
  final VoidCallback? onCertficates;
  final VoidCallback? onContact;

  const FancyNavBar({
    super.key,
    this.onAbout,
    this.onSkills,
    this.onProjects,
    this.onCertficates,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Glass(
        blur: 16,
        opacity: 0.10,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NavItem('About', onTap: onAbout),
            const SizedBox(width: 22),
            NavItem('Skills', onTap: onSkills),
            const SizedBox(width: 22),
            NavItem('Projects', onTap: onProjects),
            const SizedBox(width: 22),
            NavItem('Certificate', onTap: onProjects),
            const SizedBox(width: 22),
            NavItem('Contact', onTap: onContact),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const NavItem(this.label, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'glass.dart';

class FancyNavBar extends StatelessWidget {
  final VoidCallback? onAbout;
  final VoidCallback? onSkills;
  final VoidCallback? onProjects;
  final VoidCallback? onCertficates;
  final VoidCallback? onContact;
  final bool isScrolling; // <-- NEW

  const FancyNavBar({
    super.key,
    this.onAbout,
    this.onSkills,
    this.onProjects,
    this.onCertficates,
    this.onContact,
    this.isScrolling = false, // default
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 650;

    final items = [
      NavItem('About', onTap: onAbout),
      NavItem('Skills', onTap: onSkills),
      NavItem('Projects', onTap: onProjects),
      NavItem('Certificates', onTap: onCertficates),
      NavItem('Contact', onTap: onContact),
    ];

    return Center(
      child: Glass(
        blur: 16,
        opacity: 0.10,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        child: isMobile
            ? Wrap(
                spacing: 14,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: items,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children:
                    items
                        .expand((item) => [item, const SizedBox(width: 22)])
                        .toList()
                      ..removeLast(),
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

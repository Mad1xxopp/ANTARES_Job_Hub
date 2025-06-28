import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import '../data/dummy_data.dart';
import '../widgets/specialization_card.dart';
import 'application_form.dart';
import '../provider/applications_provider.dart';

class SpecializationsScreen extends StatefulWidget {
  const SpecializationsScreen({super.key});

  @override
  State<SpecializationsScreen> createState() => _SpecializationsScreenState();
}

class _SpecializationsScreenState extends State<SpecializationsScreen> {
  bool _isLoading = true;
  String _searchQuery = '';
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  void _showApplicationDialog(BuildContext context, String specialization) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Отклик на "$specialization"',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const ApplicationForm(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ApplicationsProvider>(context, listen: false)
                        .addApplication(specialization);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Отклик на $specialization отправлен!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Отправить заявку'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showContactDialog(BuildContext context, String phoneNumber) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 16),
              Text(
                'Контактный телефон',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _formatPhoneNumber(phoneNumber),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Закрыть'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.phone),
                      label: const Text('Позвонить'),
                      onPressed: () async {
                        final url = Uri.parse('tel:$phoneNumber');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Не удалось совершить звонок')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 11) {
      return '+${phoneNumber.substring(0, 1)} (${phoneNumber.substring(1, 4)}) '
          '${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7, 9)}-${phoneNumber.substring(9)}';
    }
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final applications = Provider.of<ApplicationsProvider>(context).applications;

    // фильтрация и сортировка
    final filteredSpecializations = DummyData.specializations
        .where((spec) => spec.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList()
      ..sort((a, b) => _sortAscending
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Специализации ANTARES'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_sortAscending ? Icons.sort_by_alpha : Icons.sort_by_alpha_outlined),
            tooltip: _sortAscending ? 'Сортировка А–Я' : 'Сортировка Я–А',
            onPressed: () {
              setState(() => _sortAscending = !_sortAscending);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Поиск специализаций...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          )
              : GridView.builder(
            itemCount: filteredSpecializations.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final spec = filteredSpecializations[index];
              final isApplied = applications.contains(spec.title);

              return SpecializationCard(
                specialization: spec,
                isApplied: isApplied,
                onTap: () => _showApplicationDialog(context, spec.title),
                onContactTap: () => _showContactDialog(context, spec.contactPhone),
              );
            },
          ),
        ),
      ),
    );
  }
}

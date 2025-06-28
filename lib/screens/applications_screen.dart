import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/applications_provider.dart';
import 'specializations_screen.dart';
import '../widgets/shimmer_widget.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
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

  Future<void> _refreshApplications(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void _showDeleteDialog(BuildContext context, String application) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить отклик?'),
        content: const Text('Вы уверены, что хотите удалить этот отклик?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ApplicationsProvider>(context, listen: false)
                  .removeApplication(application);
              Navigator.of(ctx).pop();
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicationsProvider = Provider.of<ApplicationsProvider>(context);
    final allApplications = applicationsProvider.applications;

    // Поиск и сортировка
    List<String> filteredApplications = allApplications
        .where((app) => app.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    filteredApplications.sort((a, b) => _sortAscending
        ? a.compareTo(b)
        : b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои отклики'),
        centerTitle: true,
        leading: Navigator.canPop(context) ? const BackButton() : null,
        actions: [
          IconButton(
            icon: Icon(
              _sortAscending ? Icons.sort_by_alpha : Icons.sort_by_alpha_outlined,
            ),
            tooltip: _sortAscending ? 'Сортировка А–Я' : 'Сортировка Я–А',
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() {
                _searchQuery = value;
              }),
              decoration: InputDecoration(
                hintText: 'Поиск откликов...',
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
      body: RefreshIndicator(
        onRefresh: () => _refreshApplications(context),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? _buildSkeleton()
              : filteredApplications.isEmpty
              ? _buildEmptyState(context)
              : ListView.builder(
            itemCount: filteredApplications.length,
            itemBuilder: (context, index) {
              final app = filteredApplications[index];
              return Dismissible(
                key: Key(app),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  _showDeleteDialog(context, app);
                  return false;
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(app),
                    subtitle: const Text('Отклик отправлен'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Отклик: $app'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ShimmerWidget(height: 70),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'Сейчас тут пусто',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Загляните в подборку специальностей',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SpecializationsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Смотреть специальности',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

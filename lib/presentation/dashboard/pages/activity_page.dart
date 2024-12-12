import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/show_alert.dart';
import '../../../data/models/responses/transaction_list_response_model.dart';
import '../widgets/month_picker_button.dart';
import '../bloc/transaction_list/transaction_list_bloc.dart';
import '../../transaction/widgets/transaction_detail_dialog.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart'; 


class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final searchController = TextEditingController();
  String searchQuery = '';
  String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  
  final int _limit = 10;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  final _scrollController = ScrollController();
  List<Transaction> _transactions = [];
  String? _lastTransactionId;
  bool _showBackToTopButton = false;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _initializeTab();
    _setupScrollController();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _tabController.dispose();
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      final showButton = _scrollController.offset > 100;
      if (_showBackToTopButton != showButton) {
        setState(() {
          _showBackToTopButton = showButton;
        });
      }

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8 &&
          !_isLoadingMore &&
          _hasMore) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      final type = _tabController.index == 0 ? 'income' : 'expenses';
      print('🔄 Loading more data for type: $type, search: $searchQuery');
      
      context.read<TransactionListBloc>().add(
        TransactionListEvent.loadMoreTransactions(
          userId: authData!.userId!,
          month: currentMonth,
          type: type,
          lastTransactionId: _lastTransactionId!,
          limit: _limit,
          searchQuery: searchQuery,
        ),
      );
    }
  }

  void _initializeTab() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      final type = _tabController.index == 0 ? 'income' : 'expenses';
      print('📑 Tab changed to: $type');
      
      // Unfocus search input saat ganti tab
      FocusScope.of(context).unfocus();
      
      // Reset data tanpa mengubah search query
      setState(() {
        _transactions = [];
        _lastTransactionId = null;
        _hasMore = true;
        _isLoadingMore = false;
      });
      
      _getInitialData();
    });
    _getInitialData();
  }

  void _resetAndLoadData() {
    final type = _tabController.index == 0 ? 'income' : 'expenses';
    print('🔄 Resetting data for type: $type');
    print('🔍 Current search: "$searchQuery"');
    
    // Unfocus search input
    FocusScope.of(context).unfocus();
    
    setState(() {
      _transactions = [];
      _lastTransactionId = null;
      _hasMore = true;
      _isLoadingMore = false;
    });
    
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      final type = _tabController.index == 0 ? 'income' : 'expenses';
      print('🔄 Getting initial data for type: $type, search: $searchQuery');
      
      context.read<TransactionListBloc>().add(
        TransactionListEvent.getAllTransactionsByType(
          userId: authData!.userId!,
          month: currentMonth,
          type: type,
          limit: _limit,
          searchQuery: searchQuery,
        ),
      );
    }
  }

  void _showMonthPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SpaceHeight(16.0),
            Expanded(
              child: SfDateRangePicker(
                view: DateRangePickerView.year,
                selectionMode: DateRangePickerSelectionMode.single,
                showNavigationArrow: true,
                initialSelectedDate: DateFormat('yyyy-MM').parse(currentMonth),
                minDate: DateTime(2020),
                maxDate: DateTime(2025),
                monthFormat: 'MMMM',
                enableMultiView: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                showActionButtons: false,
                allowViewNavigation: false,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                  textStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.primary,
                    fontSize: 14,
                  ),
                  todayTextStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                selectionColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.primary,
                todayHighlightColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.5)
                    : Colors.greenAccent,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value != null) {
                    final selectedDate = args.value as DateTime;
                    final formattedMonth = DateFormat('yyyy-MM').format(selectedDate);
                    
                    Navigator.pop(context);
                    setState(() {
                      currentMonth = formattedMonth;
                      _transactions = [];
                      _lastTransactionId = null;
                      _hasMore = true;
                    });
                    _getInitialData();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: searchController,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
          // Trigger search saat user tap outside
          if (searchController.text != searchQuery) {
            setState(() {
              searchQuery = searchController.text.trim();
            });
          }
        },
        decoration: InputDecoration(
          hintText: 'Cari berdasarkan kategori, catatan, atau nominal',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchQuery = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onSubmitted: (value) {
          // Trigger search saat user tekan enter
          setState(() {
            searchQuery = value.trim();
          });
        },
        onChanged: (value) {
          // Cancel previous timer jika ada
          if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
          
          // Set timer baru
          _searchDebounce = Timer(const Duration(milliseconds: 500), () {
            if (mounted && value == searchController.text) {
              print('🔍 Searching for: "$value"');
              setState(() {
                searchQuery = value.trim();
              });
            }
          });
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 48, color: Colors.grey[400]),
          const SpaceHeight(16.0),
          Text(
            'Tidak ada transaksi',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionListView(List<Transaction> transactions) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (mounted) {
          setState(() {
            _showBackToTopButton = scrollInfo.metrics.pixels > 100;
          });
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == transactions.length) {
            return _isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox();
          }

          final transaction = transactions[index];
          return _buildTransactionCard(transaction);
        },
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode 
              ? Colors.white.withOpacity(0.1)
              : AppColors.primary.withOpacity(0.1),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: transaction.type == 'income'
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            transaction.type == 'income' ? Icons.arrow_upward : Icons.arrow_downward,
            color: transaction.type == 'income' ? Colors.green : Colors.red,
          ),
        ),
        title: Text(transaction.category),
        subtitle: transaction.note?.isNotEmpty ?? false
            ? Text(transaction.note!)
            : null,
        trailing: Text(
          NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(transaction.amount),
          style: TextStyle(
            color: transaction.type == 'income' ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => TransactionDetailDialog(
            transaction: transaction,
            summarySaving: 0,
          ),
        ),
      ),
    );
  }

  List<Transaction> _filterTransactions(List<Transaction> transactions, String query) {
    if (query.isEmpty) return transactions;
    
    final searchLower = query.toLowerCase();
    
    // Bersihkan query dari format currency (Rp, titik, koma)
    final cleanQuery = query.replaceAll(RegExp(r'[Rp.,\s]'), '');
    final numericSearch = int.tryParse(cleanQuery);
    
    return transactions.where((transaction) {
      // Cari berdasarkan kategori
      final categoryMatch = transaction.category.toLowerCase().contains(searchLower);
      
      // Cari berdasarkan catatan jika ada
      final noteMatch = transaction.note?.toLowerCase().contains(searchLower) ?? false;
      
      // Cari berdasarkan nominal
      bool amountMatch = false;
      if (numericSearch != null) {
        // Format amount ke string untuk pencarian partial
        final amountStr = transaction.amount.toString();
        // Cek apakah query ada dalam nominal
        amountMatch = amountStr.contains(cleanQuery);
        
        // Jika tidak match, coba bandingkan nilai numerik
        if (!amountMatch) {
          amountMatch = transaction.amount == numericSearch;
        }
      }
      
      return categoryMatch || noteMatch || amountMatch;
    }).toList();
  }

  Widget _buildTransactionList(String type) {
    return BlocConsumer<TransactionListBloc, TransactionListState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            showAlert(
              context: context,
              message: message,
              dialogType: DialogType.error,
            );
          },
          loaded: (data) {
            print('📥 Received ${data.data.transactions.length} transactions');
            print('🔍 Current search query: "$searchQuery"');
            
            setState(() {
              if (_lastTransactionId == null) {
                _transactions = data.data.transactions;
              } else {
                final existingIds = _transactions.map((t) => t.id).toSet();
                final newTransactions = data.data.transactions
                    .where((t) => !existingIds.contains(t.id))
                    .toList();
                _transactions.addAll(newTransactions);
              }

              if (data.data.transactions.isNotEmpty) {
                _lastTransactionId = data.data.transactions.last.id;
                _hasMore = data.data.transactions.length >= _limit;
              } else {
                _hasMore = false;
              }
              
              _isLoadingMore = false;
            });
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
          loaded: (_) {
            // Filter berdasarkan tipe dulu
            final typeFilteredTransactions = _transactions.where((t) => t.type == type).toList();
            // Kemudian filter berdasarkan search query
            final filteredTransactions = _filterTransactions(typeFilteredTransactions, searchQuery);
            
            print('📊 After type filter: ${typeFilteredTransactions.length} transactions');
            print('📊 After search filter: ${filteredTransactions.length} transactions');
            
            return filteredTransactions.isEmpty
                ? _buildEmptyState()
                : _buildTransactionListView(filteredTransactions);
          },
        );
      },
    );
  }

  double _getScrollPosition() {
    if (!_scrollController.hasClients) return 0;
    
    final position = _scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    
    // Kalkulasi posisi relatif (0-1)
    return (currentScroll / maxScroll).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivitas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pemasukan'),
            Tab(text: 'Pengeluaran'),
          ],
        ),
      ),
      body: Column(
        children: [
          MonthPickerButton(
            currentMonth: currentMonth,
            onTap: () => _showMonthPicker(context),
          ),
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionList('income'),
                _buildTransactionList('expenses'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTopButton
          ? Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              child: FloatingActionButton(
                backgroundColor: isDarkMode ? Colors.white : AppColors.primary,
                foregroundColor: isDarkMode ? AppColors.primary : Colors.white,
                elevation: 8,
                onPressed: () {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Icon(Icons.keyboard_arrow_up),
              ),
            )
          : null,
    );
  }
} 
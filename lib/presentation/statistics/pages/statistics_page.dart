import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/core.dart';
import '../../../data/datasources/analytics_local_datasource.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../../data/datasources/transaction_local_datasource.dart';
import '../../../data/models/responses/financial_trend_response_model.dart';
import '../../../data/models/responses/predict_spending_response_model.dart';
import '../bloc/analytics_bloc.dart';
import '../../dashboard/widgets/month_picker_button.dart';

class IncomeCategory {
  final String category;
  final int amount;

  IncomeCategory({
    required this.category,
    required this.amount,
  });
}

class ExpenseCategory {
  final String category;
  final int amount;

  ExpenseCategory({
    required this.category,
    required this.amount,
  });
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = true;
  bool _isAtTop = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _getInitialData();

    _scrollController.addListener(() {
      setState(() {
        _showScrollButton = true;

        _isAtTop = _scrollController.position.pixels <
            (_scrollController.position.maxScrollExtent / 2);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_isAtTop) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _getInitialData() async {
    if (_isInitialized) return;
    
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      await _loadAllData(authData!.userId!);
      _isInitialized = true;
    }
  }

  Future<void> _loadAllData(String userId) async {
    print('🔄 Loading all data for user: $userId, month: $currentMonth');

    // Load predict spending (will use cache if available)
    context.read<AnalyticsBloc>().add(
      AnalyticsEvent.getPredictSpending(
        userId: userId,
        month: currentMonth,
      ),
    );

    // Load other analytics data
    // ... rest of analytics loading
  }

  Future<void> _onRefresh() async {
    print('🔄 Refreshing data');
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      // Clear all caches
      await _analyticsLocalDatasource.clearCache();
      await TransactionLocalDatasource().clearCache();
      print('🗑️ All caches cleared');
      
      // Reload all data fresh
      _loadAllData(authData!.userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Keuangan'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButton: _showScrollButton
          ? FloatingActionButton.small(
              onPressed: _handleScroll,
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              child: Icon(
                _isAtTop ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: isDarkMode ? Colors.black : Colors.white,
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              MonthPickerButton(
                currentMonth: currentMonth,
                onTap: () => _showMonthPicker(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
                  builder: (context, state) {
                    print('🔄 Current state: $state');
                    return state.maybeWhen(
                      orElse: () {
                        print('⚪️ orElse case');
                        return const SizedBox();
                      },
                      loading: () {
                        print('⏳ Loading state');
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 8),
                                Text('Menganalisis data keuangan...'),
                              ],
                            ),
                          ),
                        );
                      },
                      loadedPrediction: (data) {
                        print('✅ Loaded prediction state');
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          child: _buildPredictionCard(data),
                        );
                      },
                      error: (message) {
                        print('❌ Error state: $message');
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.error_outline,
                                      color: Colors.red, size: 48),
                                  const SizedBox(height: 8),
                                  Text(
                                    message,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  TextButton(
                                    onPressed: () => _getInitialData(),
                                    child: const Text('Coba Lagi'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildAnalyticsCard(
                    'Tren Keuangan',
                    Icons.trending_up,
                    () => _showTrendDetails(context),
                    isDarkMode,
                  ),
                  _buildAnalyticsCard(
                    'Distribusi Pendapatan',
                    Icons.pie_chart,
                    () => _showIncomeDistribution(context),
                    isDarkMode,
                  ),
                  _buildAnalyticsCard(
                    'Distribusi Pengeluaran',
                    Icons.pie_chart_outline,
                    () => _showExpensesDistribution(context),
                    isDarkMode,
                  ),
                  _buildAnalyticsCard(
                    'Ringkasan Bulanan',
                    Icons.analytics,
                    () => _showMonthlySummary(context),
                    isDarkMode,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMonthPicker(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

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
            const SizedBox(height: 16),
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
                showActionButtons: false,
                backgroundColor: backgroundColor,
                allowViewNavigation: false,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: backgroundColor,
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                yearCellStyle: DateRangePickerYearCellStyle(
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                  todayTextStyle: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
                selectionColor:
                    isDarkMode ? AppColors.white : AppColors.primary,
                todayHighlightColor: isDarkMode
                    ? Colors.white.withOpacity(0.5)
                    : Colors.greenAccent,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value != null) {
                    final selectedDate = args.value as DateTime;
                    final formattedMonth =
                        DateFormat('yyyy-MM').format(selectedDate);

                    setState(() {
                      currentMonth = formattedMonth;
                    });

                    // Reload data for both tabs with new month
                    _loadDataForCurrentMonth();
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadDataForCurrentMonth() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      _loadAllData(authData!.userId!);
    }
  }

  Widget _buildIncomeDistribution(bool isDarkMode) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loadedDistribution: (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Distribusi Pendapatan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            overflowMode: LegendItemOverflowMode.wrap,
                            textStyle: TextStyle(
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            format: 'point.x : Rp point.y',
                          ),
                          series: <CircularSeries>[
                            PieSeries<IncomeCategory, String>(
                              dataSource: List.generate(
                                data.categories.length,
                                (index) => IncomeCategory(
                                  category: data.categories[index],
                                  amount: data.amounts[index],
                                ),
                              ),
                              xValueMapper: (IncomeCategory data, _) =>
                                  data.category,
                              yValueMapper: (IncomeCategory data, _) =>
                                  data.amount,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                textStyle: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              enableTooltip: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Pendapatan',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(data.totalIncome),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  Widget _buildTrendAnalysis(bool isDarkMode) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loadedTrend: (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Savings Progress Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Target Tabungan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: data.savings / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          data.savings >= 30 ? Colors.green : Colors.orange,
                        ),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress ${data.savings}%',
                            style: TextStyle(
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          Text(
                            'Target Saving',
                            style: TextStyle(
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Cash Flow Analysis
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analisis Arus Kas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCashFlowItem(
                              'Pemasukan',
                              data.totalIncome,
                              Icons.arrow_upward,
                              Colors.green,
                              isDarkMode,
                            ),
                          ),
                          Expanded(
                            child: _buildCashFlowItem(
                              'Pengeluaran',
                              data.totalExpenses,
                              Icons.arrow_downward,
                              Colors.red,
                              isDarkMode,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Arus Kas Bersih',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(data.netCashFlow),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: data.netCashFlow >= 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Income & Expense Trend Chart
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tren Keuangan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SfCartesianChart(
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            format: 'point.x : Rp point.y',
                          ),
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat('dd MMM'),
                            intervalType: DateTimeIntervalType.days,
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            numberFormat: NumberFormat.compact(locale: 'id'),
                            majorGridLines: const MajorGridLines(width: 0.5),
                          ),
                          series: <CartesianSeries<TransactionTrend, DateTime>>[
                            LineSeries<TransactionTrend, DateTime>(
                              name: 'Pemasukan',
                              dataSource: data.income,
                              xValueMapper: (trend, _) => trend.date,
                              yValueMapper: (trend, _) => trend.amount,
                              color: Colors.green,
                              markerSettings:
                                  const MarkerSettings(isVisible: true),
                            ),
                            LineSeries<TransactionTrend, DateTime>(
                              name: 'Pengeluaran',
                              dataSource: data.expenses,
                              xValueMapper: (trend, _) => trend.date,
                              yValueMapper: (trend, _) => trend.amount,
                              color: Colors.red,
                              markerSettings:
                                  const MarkerSettings(isVisible: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  Widget _buildCashFlowItem(
    String title,
    int amount,
    IconData icon,
    Color color,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(amount),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildExpensesDistribution(bool isDarkMode) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loadedExpenses: (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Distribusi Pengeluaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SfCircularChart(
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                            overflowMode: LegendItemOverflowMode.wrap,
                            textStyle: TextStyle(
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            format: 'point.x : Rp point.y',
                          ),
                          series: <CircularSeries>[
                            PieSeries<ExpenseCategory, String>(
                              dataSource: List.generate(
                                data.categories.length,
                                (index) => ExpenseCategory(
                                  category: data.categories[index],
                                  amount: data.amounts[index],
                                ),
                              ),
                              xValueMapper: (data, _) => data.category,
                              yValueMapper: (data, _) => data.amount,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                textStyle: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                              enableTooltip: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Pengeluaran',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(data.totalExpenses),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  Widget _buildMonthlySummary(bool isDarkMode) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loadedSummary: (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Income & Expense Breakdown Chart
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Breakdown Keuangan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SfCartesianChart(
                          legend: Legend(
                            isVisible: true,
                            position: LegendPosition.bottom,
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            format: 'point.x : Rp point.y',
                          ),
                          primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            numberFormat: NumberFormat.compact(locale: 'id'),
                            majorGridLines: const MajorGridLines(width: 0.5),
                          ),
                          series: <CartesianSeries<BreakdownData, String>>[
                            // Income Line
                            LineSeries<BreakdownData, String>(
                              name: 'Pemasukan',
                              dataSource: [
                                for (int i = 0;
                                    i < data.incomeBreakdown.categories.length;
                                    i++)
                                  BreakdownData(
                                    category:
                                        data.incomeBreakdown.categories[i],
                                    amount: data.incomeBreakdown.amounts[i],
                                  ),
                              ],
                              xValueMapper: (BreakdownData data, _) =>
                                  data.category,
                              yValueMapper: (BreakdownData data, _) =>
                                  data.amount,
                              color: Colors.green,
                              markerSettings:
                                  const MarkerSettings(isVisible: true),
                            ),
                            // Expense Line
                            LineSeries<BreakdownData, String>(
                              name: 'Pengeluaran',
                              dataSource: [
                                for (int i = 0;
                                    i <
                                        data.expensesBreakdown.categories
                                            .length;
                                    i++)
                                  BreakdownData(
                                    category:
                                        data.expensesBreakdown.categories[i],
                                    amount: data.expensesBreakdown.amounts[i],
                                  ),
                              ],
                              xValueMapper: (BreakdownData data, _) =>
                                  data.category,
                              yValueMapper: (BreakdownData data, _) =>
                                  data.amount,
                              color: Colors.red,
                              markerSettings:
                                  const MarkerSettings(isVisible: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Summary Cards
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSummaryItem(
                        'Total Pendapatan',
                        data.totalIncome,
                        Colors.green,
                        isDarkMode,
                      ),
                      const Divider(height: 24),
                      _buildSummaryItem(
                        'Total Pengeluaran',
                        data.totalExpenses,
                        Colors.red,
                        isDarkMode,
                      ),
                      const Divider(height: 24),
                      _buildSummaryItem(
                        'Arus Kas Bersih',
                        data.netCashFlow,
                        data.netCashFlow >= 0 ? Colors.green : Colors.red,
                        isDarkMode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }

  Widget _buildSummaryItem(
      String title, int amount, Color color, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        Text(
          NumberFormat.currency(
            locale: 'id',
            symbol: 'Rp ',
            decimalDigits: 0,
          ).format(amount),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCard(
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isDarkMode,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isDarkMode ? AppColors.white : AppColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTrendDetails(BuildContext context) async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      context.read<AnalyticsBloc>().add(
            AnalyticsEvent.getFinancialTrend(
              userId: authData!.userId!,
              month: currentMonth,
            ),
          );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: _buildTrendAnalysis(
            Theme.of(context).brightness == Brightness.dark),
      ),
    );
  }

  void _showIncomeDistribution(BuildContext context) async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      context.read<AnalyticsBloc>().add(
            AnalyticsEvent.getIncomeDistribution(
              userId: authData!.userId!,
              month: currentMonth,
            ),
          );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: _buildIncomeDistribution(
            Theme.of(context).brightness == Brightness.dark),
      ),
    );
  }

  void _showExpensesDistribution(BuildContext context) async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      context.read<AnalyticsBloc>().add(
            AnalyticsEvent.getExpensesDistribution(
              userId: authData!.userId!,
              month: currentMonth,
            ),
          );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: _buildExpensesDistribution(
            Theme.of(context).brightness == Brightness.dark),
      ),
    );
  }

  void _showMonthlySummary(BuildContext context) async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData?.userId != null && mounted) {
      context.read<AnalyticsBloc>().add(
            AnalyticsEvent.getMonthlySummary(
              userId: authData!.userId!,
              month: currentMonth,
            ),
          );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: _buildMonthlySummary(
            Theme.of(context).brightness == Brightness.dark),
      ),
    );
  }

  final _analyticsLocalDatasource = AnalyticsLocalDatasource();

  Widget _buildPredictionCard(PredictSpendingResponseModel data) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isHighRisk = data.spendingStatus.level == "HIGH RISK";

    // Custom colors dari hex code
    final redColor = const Color(0xFFDA1E28);
    final orangeColor = const Color(0xFFFF832B);
    // final yellowColor = const Color(0xFFF1C21B);
    // final greenColor = const Color(0xFF24A148);

    // Definisi warna yang lebih soft
    final cardColor = isDarkMode
        ? (isHighRisk
            ? redColor.withOpacity(0.15)
            : orangeColor.withOpacity(0.15))
        : (isHighRisk
            ? redColor.withOpacity(0.05)
            : orangeColor.withOpacity(0.05));

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isHighRisk
              ? redColor.withOpacity(isDarkMode ? 0.2 : 0.1)
              : orangeColor.withOpacity(isDarkMode ? 0.2 : 0.1),
          width: 1,
        ),
      ),
      color: cardColor,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: cardColor,
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: gradientColors,
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: isDarkMode
          //         ? Colors.black.withOpacity(0.2)
          //         : Colors.black.withOpacity(0.05),
          //     blurRadius: 8,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Icon and Status Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHighRisk
                        ? redColor.withOpacity(0.1)
                        : orangeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isHighRisk
                          ? redColor.withOpacity(0.2)
                          : orangeColor.withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                    isHighRisk
                        ? Icons.warning_amber_rounded
                        : Icons.insights_rounded,
                    color: isHighRisk ? redColor : orangeColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analisis Keuangan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.w600, // Sedikit kurangi ketebalan
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.95)
                              : Colors.black.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          // color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: (isDarkMode ? Colors.white : Colors.black)
                                .withOpacity(0.05),
                          ),
                        ),
                        child: Text(
                          data.spendingStatus.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.8)
                                : Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Financial Health Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kesehatan Keuangan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      '${(data.riskAssessment.financialHealthIndex * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getHealthColor(
                            data.riskAssessment.financialHealthIndex),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: data.riskAssessment.financialHealthIndex,
                      minHeight: 12,
                      backgroundColor: isDarkMode
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getHealthColor(
                            data.riskAssessment.financialHealthIndex),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Alert Message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (isDarkMode ? Colors.white : Colors.black)
                    .withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (isDarkMode ? Colors.white : Colors.black)
                      .withOpacity(0.1),
                ),
              ),
              child: Text(
                data.alert.message,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.9)
                      : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendations
            Text(
              'Rekomendasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            ...data.alert.recommendations.map((rec) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(right: 12, top: 2),
                        decoration: BoxDecoration(
                          color: (isDarkMode ? Colors.white : Colors.green)
                              .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: isDarkMode ? Colors.white : Colors.green,
                          size: 14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rec,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.9)
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Color _getHealthColor(double index) {
    // Custom colors untuk health indicator
    if (index < 0.3) return const Color(0xFFDA1E28); // Red
    if (index < 0.7) return const Color(0xFFFF832B); // Orange
    return const Color(0xFF24A148); // Green
  }
}

// Helper class untuk data breakdown
class BreakdownData {
  final String category;
  final int amount;

  BreakdownData({
    required this.category,
    required this.amount,
  });
}

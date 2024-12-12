import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/scheduler.dart';
import '../../../core/constants/colors.dart';
import '../../../core/components/spaces.dart';
import '../../../core/router/app_router.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../bloc/transaction_list/transaction_list_bloc.dart';
import '../../transaction/widgets/transaction_detail_dialog.dart';
import '../../transaction/widgets/update_saving_dialog.dart';
import '../widgets/error_state.dart';
import '../../../core/utils/show_alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  String? userId;
  String? username;

  @override
  void initState() {
    super.initState();
    currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final savedUsername = await AuthLocalDatasource().getUsername();
    if (mounted) {
      setState(() {
        username = savedUsername;
      });
    }
    if (authData?.userId != null) {
      userId = authData!.userId!;
      if (mounted) {
        context.read<TransactionListBloc>().add(
              TransactionListEvent.getTransactions(
                userId: userId!,
                month: currentMonth,
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Definisikan warna adaptif
    final backgroundColor = isDarkMode ? AppColors.black : AppColors.white;
    final textColor = isDarkMode ? AppColors.white : AppColors.primary;
    final secondaryTextColor =
        isDarkMode ? AppColors.grey : AppColors.secondary;
    final cardColor = isDarkMode
        ? AppColors.primary.withOpacity(0.8)
        : const Color(0xFFF8F9FA);
    final cardTextColor = isDarkMode ? Colors.white : AppColors.primary;
    final mutedTextColor = isDarkMode
        ? Colors.white.withOpacity(0.7)
        : AppColors.secondary.withOpacity(0.7);

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            if (userId != null) {
              context.read<TransactionListBloc>().add(
                    TransactionListEvent.refreshTransactions(
                      userId: userId!,
                      month: currentMonth,
                    ),
                  );
            }
          },
          child: BlocListener<TransactionListBloc, TransactionListState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  showAlert(
                    context: context,
                    message: message,
                    dialogType: DialogType.error,
                    autoDismiss: true,
                  );
                },
              );
            },
            child: BlocBuilder<TransactionListBloc, TransactionListState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(child: CircularProgressIndicator()),
                  loaded: (data) => ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // Profile Section with Notification Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: textColor.withOpacity(0.1),
                                child: Icon(Icons.person, color: textColor),
                              ),
                              const SpaceWidth(12.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi,',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: secondaryTextColor,
                                    ),
                                  ),
                                  Text(
                                    username ?? 'User',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Notification Icon
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? AppColors.grey.withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: textColor,
                              ),
                              onPressed: () {
                                showAlert(
                                  context: context,
                                  message: 'Coming soon!',
                                  dialogType: DialogType.info,
                                  autoDismiss: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SpaceHeight(24.0),

                      // Balance Card dengan warna yang dioptimalkan
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(.2),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Uang mu',
                              style: TextStyle(
                                color: cardTextColor,
                                fontSize: 16,
                              ),
                            ),
                            const SpaceHeight(8.0),
                            Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(data.data.summary.balance),
                              style: TextStyle(
                                color: cardTextColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SpaceHeight(16.0),
                            // Progress Bar Container
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => UpdateSavingDialog(
                                    currentSaving: data.data.summary.saving,
                                    currentMonth: currentMonth,
                                    userId: userId!,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.1)
                                      : textColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.2)
                                        : textColor.withOpacity(0.1),
                                  ),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Target Tabungan',
                                              style: TextStyle(
                                                color: cardTextColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SpaceWidth(4.0),
                                            Icon(
                                              Icons.edit,
                                              color:
                                                  cardTextColor.withOpacity(0.7),
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDarkMode
                                                ? Colors.white.withOpacity(0.2)
                                                : textColor.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            '${data.data.summary.saving}%',
                                            style: TextStyle(
                                              color: cardTextColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SpaceHeight(8.0),
                                    LinearProgressIndicator(
                                      value: (data.data.summary.saving / 100)
                                          .clamp(0.0, 1.0),
                                      backgroundColor: isDarkMode
                                          ? Colors.white.withOpacity(0.2)
                                          : textColor.withOpacity(0.1),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          cardTextColor),
                                      minHeight: 8,
                                      color: cardTextColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    const SpaceHeight(4.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rekomendasi: ${data.data.summary.recommendedSavings}',
                                          style: TextStyle(
                                            color: mutedTextColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        // Text(
                                        //   'Rekomendasi: ${NumberFormat.compact(
                                        //     locale: 'id',
                                        //   ).format(data.data.summary.recommendedSavings)}',
                                        //   style: TextStyle(
                                        //     color: mutedTextColor,
                                        //     fontSize: 12,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Month Selector dan Transaction List Section
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16.0),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Container(
                                      height: 400,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
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
                                              backgroundColor: backgroundColor,
                                              showActionButtons: false,
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
                                              selectionColor: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.primary,
                                              todayHighlightColor: isDarkMode
                                                  ? Colors.white.withOpacity(0.5)
                                                  : Colors.greenAccent,
                                              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                                if (args.value != null) {
                                                  final selectedDate = args.value as DateTime;
                                                  final formattedMonth = DateFormat('yyyy-MM').format(selectedDate);
                                                  
                                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      currentMonth = formattedMonth;
                                                    });

                                                    if (userId != null && mounted) {
                                                      context.read<TransactionListBloc>().add(
                                                        TransactionListEvent.getTransactions(
                                                          userId: userId!,
                                                          month: formattedMonth,
                                                        ),
                                                      );
                                                    }
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppColors.grey.withOpacity(0.1)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.white.withOpacity(0.1)
                                          : AppColors.primary.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary
                                                  .withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: isDarkMode
                                                  ? AppColors.white
                                                  : AppColors.primary,
                                              size: 18,
                                            ),
                                          ),
                                          const SpaceWidth(12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Periode',
                                                style: TextStyle(
                                                  color: secondaryTextColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                data.data.summary.month,
                                                style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: isDarkMode
                                              ? AppColors.white
                                              : AppColors.primary,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SpaceHeight(16.0),

                            // Transactions List atau Empty State
                            if (data.data.transactions.isEmpty)
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 32.0),
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? AppColors.grey.withOpacity(0.1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long_outlined,
                                      size: 48,
                                      color: secondaryTextColor.withOpacity(0.5),
                                    ),
                                    const SpaceHeight(8.0),
                                    Text(
                                      'Belum ada transaksi',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SpaceHeight(4.0),
                                    Text(
                                      'di ${data.data.summary.month}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else ...[
                              ...data.data.transactions.take(5).map(
                                    (transaction) => Dismissible(
                                      key: Key(transaction.id),
                                      background: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        alignment: Alignment.centerRight,
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                      ),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) async {
                                        return await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Konfirmasi Hapus'),
                                            content: const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                child: Text(
                                                  'Batal',
                                                  style: TextStyle(color: Colors.grey[600]),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, true),
                                                style: TextButton.styleFrom(foregroundColor: Colors.red),
                                                child: const Text('Hapus'),
                                              ),
                                            ],
                                          ),
                                        ) ?? false;
                                      },
                                      onDismissed: (direction) {
                                        context.read<TransactionListBloc>().add(
                                          TransactionListEvent.deleteTransaction(
                                            transactionId: transaction.id,
                                            month: DateFormat('yyyy-MM').format(transaction.date),
                                          ),
                                        );

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Transaksi berhasil dihapus'),
                                            backgroundColor: Colors.green,
                                            behavior: SnackBarBehavior.fixed,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(16),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 8.0),
                                        decoration: BoxDecoration(
                                          color: isDarkMode 
                                              ? AppColors.grey.withOpacity(0.1)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isDarkMode
                                                ? Colors.white.withOpacity(0.1)
                                                : AppColors.primary.withOpacity(0.1),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.black.withOpacity(0.05),
                                              blurRadius: 10,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  TransactionDetailDialog(
                                                transaction: transaction,
                                                summarySaving:
                                                    data.data.summary.saving,
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(12),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                // Icon Transaksi
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: transaction.type == 'income'
                                                        ? Colors.green.withOpacity(0.1)
                                                        : Colors.red.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Icon(
                                                    transaction.type == 'income'
                                                        ? Icons.arrow_upward
                                                        : Icons.arrow_downward,
                                                    color: transaction.type == 'income'
                                                        ? Colors.green
                                                        : Colors.red,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SpaceWidth(12),
                                                // Informasi Transaksi
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        transaction.category,
                                                        style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      if (transaction.note != null && transaction.note!.isNotEmpty)
                                                        Text(
                                                          transaction.note!,
                                                          style: TextStyle(
                                                            color: secondaryTextColor,
                                                            fontSize: 12,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                const SpaceWidth(12),
                                                // Nominal Transaksi
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp ',
                                                        decimalDigits: 0,
                                                      ).format(transaction.amount),
                                                      style: TextStyle(
                                                        color: transaction.type == 'income'
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('dd MMM').format(transaction.date),
                                                      style: TextStyle(
                                                        color: secondaryTextColor,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              if (data.data.transactions.length > 5)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      context.pushNamed(RouteConstants.activity);
                                    },
                                    child: const Text('Lihat Semua'),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  error: (message) => ErrorStateWidget(
                    message: message,
                    onRetry: () {
                      if (userId != null) {
                        context.read<TransactionListBloc>().add(
                              TransactionListEvent.getTransactions(
                                userId: userId!,
                                month: currentMonth,
                              ),
                            );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

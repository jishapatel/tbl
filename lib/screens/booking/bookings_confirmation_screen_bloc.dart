import 'package:rxdart/rxdart.dart';

import '../../../base/bloc/base_bloc.dart';
import '../../../base/constants/app_widgets.dart';
import '../../../base/remote/model/home_response.dart';
import '../../../base/remote/repository/auth_repository.dart';
import '../../base/remote/model/CancelBookingResponse.dart';
import '../../base/remote/model/WalletHistoryResponse.dart';
import '../../base/remote/model/bookings_response.dart';

class BookingConformationScreenBloc extends BasePageBloc {
  late BehaviorSubject<BookingsResponse> home;
  // BookingListScreenBloc() {
  //   home = BehaviorSubject<BookingsResponse>();
  // }
  // bool isUpComing = false;
  // bool isPast = false;
  //
  // int? countUpComing = 0;
  // int? countPast = 0;
  //
  // Stream<BookingsResponse> get homeResponseStream => home.stream;
  // BookingsResponse? homeResponse;
  //
  // @override
  // void dispose() {
  //   home.close();
  //   super.dispose();
  // }
  //
  // void getBookingDetails(Map? data, Function(BookingsResponse) onSuccess) {
  //   showLoadingDialog();
  //   apiReservations(data, (response) {
  //     hideLoadingDialog();
  //     homeResponse = response; // Assign the response directly
  //     countUpComing = homeResponse?.bookings?.where((item) => item.bookingDate!.isAfter(DateTime.now())).length;
  //     countPast = homeResponse?.bookings?.where((item) => item.bookingDate!.isBefore(DateTime.now())).length;
  //     if(countUpComing!>0){
  //       isUpComing = true;
  //     }
  //     if(countPast!>0){
  //       isPast = true;
  //     }
  //     home.add(homeResponse!);
  //     onSuccess.call(homeResponse!);
  //   }, (error) {
  //     hideLoadingDialog();
  //     showMessageBar(error.message ?? "");
  //   });
  // }
  //
  // void cancelBooking(Map? data, Function(CancelBookingsResponse) onSuccess) {
  //   showLoadingDialog();
  //   apiCancelBooking(data, (response) {
  //     hideLoadingDialog();
  //     onSuccess.call(response);
  //   }, (error) {
  //     hideLoadingDialog();
  //     showMessageBar(error.message ?? "");
  //   });
  // }
}

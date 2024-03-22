import '../../../../base/bloc/base_bloc.dart';
import '../../../../base/remote/model/save_booking_response.dart';
import '../../../../base/remote/model/slot_availability_response.dart';
import '../../../../base/remote/repository/auth_repository.dart';

class ReserveTableScreenBloc extends BasePageBloc {

  // late BehaviorSubject<List<DateTime>> home;
  // ReserveTableScreenBloc() {
  //   home = BehaviorSubject<List<DateTime>>();
  // }
  //   Stream<List<DateTime>> get timeSlot => home.stream;

  void doSlotAvailability(Map<String, dynamic>? data,
      Function(SlotAvailabilityResponse) onSuccess) {
    showLoadingDialog();
    apiSlotAvailability(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
     // showMessageBar(error.message ?? "");
    });
  }

  void createReservation(Map<String, dynamic>? data,
      Function(SaveBookingDetailsResponse) onSuccess) {
    showLoadingDialog();
    apiCreateReservations(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      //showMessageBar(error.message ?? "");
    });
  }

}

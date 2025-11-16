import 'package:bus_pos/features/booking/models/bus.dart';
import 'package:bus_pos/features/booking/models/seat_booking_model.dart';
import 'package:bus_pos/features/booking/utils/seat_generator.dart';

List<String> locations = ["Mombasa", "Nairobi", "Nakuru", "Kisumu", "Nyeri"];

class BusData {
  static List<Bus> getBuses() {
    return [
      Bus(
        id: '1',
        busOperator: 'UGENYA',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '19:30',
        seatsAvailable: 8,
        totalSeats: 36,
        fare: 1500,
        seats: SeatGenerator.generateSeats(36, [1, 2, 6, 9, 12, 13]),
      ),
      Bus(
        id: '2',
        busOperator: 'UGENYA',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '08:00',
        seatsAvailable: 6,
        totalSeats: 14,
        fare: 1000,
        seats: SeatGenerator.generateSeats(14, [1, 2, 4, 7, 8, 12, 13, 14]),
      ),
      Bus(
        id: '3',
        busOperator: 'NYA UGENYA',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '14:30',
        seatsAvailable: 10,
        totalSeats: 14,
        fare: 1200,
        seats: SeatGenerator.generateSeats(14, [1, 2, 12, 13]),
      ),
      Bus(
        id: '4',
        busOperator: 'ONN TRAVEL',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '06:00',
        seatsAvailable: 12,
        totalSeats: 14,
        fare: 800,
        seats: SeatGenerator.generateSeats(14, [1, 12]),
      ),
      Bus(
        id: '5',
        busOperator: 'SALAMA BUS',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '22:00',
        seatsAvailable: 5,
        totalSeats: 14,
        fare: 1800,
        seats: SeatGenerator.generateSeats(14, [1, 2, 4, 6, 7, 8, 9, 12, 13]),
      ),
      Bus(
        id: '6',
        busOperator: 'NYAMBUCHE',
        operatorLogo: '/assets/images/logo.webp',
        from: 'NAIROBI',
        to: 'MALINDI [VIA MOMBASA]',
        travelDate: DateTime(2025, 11, 20),
        time: '10:30',
        seatsAvailable: 7,
        totalSeats: 14,
        fare: 1300,
        seats: SeatGenerator.generateSeats(14, [1, 2, 4, 7, 12, 13, 14]),
      ),
    ];
  }


}

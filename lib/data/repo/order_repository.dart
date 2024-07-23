import 'package:store/common/http_client.dart';
import 'package:store/data/order.dart';
import 'package:store/data/payment_receipt.dart';
import 'package:store/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderdataSource;

  OrderRepository(this.orderdataSource);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      orderdataSource.create(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) =>
      orderdataSource.getPaymentReceipt(orderId);
      
        @override
        Future<List<OrderEntity>> getOrders() {
         return orderdataSource.getOrders();
        }
}

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart';

// bu task ları veritabanına kaydetmek için buraya anotation denilen yapıları koymamız lazım ki
// build runner çalışırken bunlara baksın buna göre bir kod üretsin.
// flutter packages pub run build_runner build termianlden çalıştırılacak
// bu  anatotaion lara göre yenş bir sınıf oluşturacak ve ben bu sayede oluşturduğum veri tabanına yazabileceğim.
@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

  Task(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.isCompleted});

// factor metotlar ne işe yarar? 
// constructorlar geriye birşey return etmez ile sınıfa dışarıdan sanki static metotmuş gibi erişme imkanı verir. Task.create()
  factory Task.create({required String name, required DateTime createdAt}) { 
    return Task(
        id: const Uuid().v1(), // o anki zamanı string hale dönüştürüp size vericek. 
        name: name,
        createdAt: createdAt,
        isCompleted: false);
  }
}

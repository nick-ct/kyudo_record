import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/shoot_controller.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kyudo_record/classes/mato_widget.dart';

class ShootRecordList extends StatefulWidget {
  const ShootRecordList({Key? key}) : super(key: key);

  @override
  State<ShootRecordList> createState() => _ShootRecordListState();
}

class _ShootRecordListState extends State<ShootRecordList> with TickerProviderStateMixin {
  final ShootController _shootController = Get.find();

  Future<void> updateMatoSize(MatoSize matoSize, ShootRound shootRound) async {
    await _shootController.updateRoundMatoSize(matoSize, shootRound);
    setState(() {});
  }

  Future<void> removeShootRound(ShootRound shootRound) async {
    await _shootController.removeShootRound(shootRound);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        itemCount: _shootController.shootRounds.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          Mato mato = Mato();
          List<ShootRecord> relatedRecords = _shootController.shootRounds[index].relatedRecord.toList();
          mato.setDisplayRecrod(relatedRecords);
          relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
          return Card(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SlidableAutoCloseBehavior(
                  child: Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.4,
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (ctx) => InkWell(
                              onTap: () async {
                                Slidable.of(ctx)?.close();
                                await removeShootRound(_shootController.shootRounds[index]);
                                _shootController.shootRounds.removeAt(index);

                                if (_shootController.shootRounds.isEmpty ||
                                    _shootController.shootRounds.last.shootCount == 4) {
                                  _shootController.newShootRound();
                                }
                              },
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        mato.drawMatoWithDisplay(scale: 0.35),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Round ' + (index + 1).toString()),
                              Text('Hit Rate ' +
                                  (_shootController.shootRounds[index].shootCount > 0
                                      ? ((_shootController.shootRounds[index].hitCount /
                                                  _shootController.shootRounds[index].shootCount *
                                                  100)
                                              .toStringAsFixed(0) +
                                          '%')
                                      : '---')),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    i < relatedRecords.length
                                        ? SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Center(
                                              child: relatedRecords[i].missed
                                                  ? const Icon(
                                                      Icons.remove,
                                                      color: Colors.grey,
                                                    )
                                                  : relatedRecords[i].hitTarget
                                                      ? const FaIcon(
                                                          FontAwesomeIcons.circle,
                                                          color: Colors.blue,
                                                        )
                                                      : const Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                            ),
                                          )
                                        : const SizedBox(
                                            width: 30,
                                            height: 30,
                                          ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (ctx) => IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey,
                            ),
                            onPressed: () => Slidable.of(ctx)?.openEndActionPane(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

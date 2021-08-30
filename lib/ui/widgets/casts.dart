import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_casts_bloc.dart';
import 'package:movie_app/model/cast.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';
import 'package:movie_app/utils/consts.dart';

class Casts extends StatefulWidget {
  final int id;

  const Casts({Key? key, required this.id}) : super(key: key);

  @override
  _CastsState createState() => _CastsState();
}

class _CastsState extends State<Casts> {
  static const title = 'CASTS';

  @override
  void initState() {
    super.initState();

    castsBloc..getCasts(widget.id);
  }

  @override
  void dispose() {
    castsBloc..drainStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.titleColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        StreamBuilder<CastResponse>(
          stream: castsBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              if (data.error.isNotEmpty) {
                return AppError(error: data.error);
              }
              return _Casts(casts: data.casts);
            }
            if (snapshot.hasError) {
              return AppError(error: snapshot.error.toString());
            }

            return Loader();
          },
        )
      ],
    );
  }
}

class _Casts extends StatelessWidget {
  final List<Cast> casts;
  const _Casts({Key? key, required this.casts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: casts.length,
        itemBuilder: (context, index) {
          final cast = casts[index];
          return Container(
            padding: const EdgeInsets.only(top: 10, left: 8),
            width: 100,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: cast.img == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '$thumbs300Url${cast.img}',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cast.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cast.character,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

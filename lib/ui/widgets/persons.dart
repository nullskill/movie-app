import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_persons_bloc.dart';
import 'package:movie_app/model/person.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';
import 'package:movie_app/utils/consts.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({Key? key}) : super(key: key);

  @override
  _PersonsListState createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {
  static const title = 'TRENDING PERSONS ON THIS WEEK';

  @override
  void initState() {
    super.initState();

    personsBloc.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: const Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.titleColor,
            ),
          ),
        ),
        SizedBox(height: 5),
        StreamBuilder<PersonResponse>(
          stream: personsBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              if (data.error.isNotEmpty) {
                return AppError(error: data.error);
              }
              return _Persons(persons: data.persons);
            }
            if (snapshot.hasError) {
              return AppError(error: snapshot.error.toString());
            }

            return Loader();
          },
        ),
      ],
    );
  }
}

class _Persons extends StatelessWidget {
  final List<Person> persons;

  const _Persons({Key? key, required this.persons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          itemCount: persons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final person = persons[index];
            return SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getPersonImage(person),
                    SizedBox(height: 10),
                    Text(
                      person.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Trending for ${person.known}',
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                        color: AppColors.titleColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getPersonImage(Person person) {
    if (person.profileImg == null) {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondColor,
        ),
        child: Icon(
          FontAwesomeIcons.userAlt,
          color: AppColors.whiteColor,
        ),
      );
    }

    return SizedBox(
      width: 70,
      height: 70,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage('$tmdbUrl${person.profileImg}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

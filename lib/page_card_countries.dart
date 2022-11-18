import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'countries_model.dart';
import 'covid_data_source.dart';


class PageCardCountries extends StatefulWidget {
  const PageCardCountries({Key? key}) : super(key: key);
  @override
  _PageCardCountriesState createState() => _PageCardCountriesState();
}
class _PageCardCountriesState extends State<PageCardCountries> {
  // final style = TextStyle(fontSize: 20, fontStyle: FontStyle.italic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center (child : Text ("COUNTRIES",
        style: TextStyle(fontFamily: 'AkayaTelivigala', fontSize: 30, fontWeight: FontWeight.bold)),),
      ),
      body: _buildCardCountriesBody(),
    );
  }
}
Widget _buildCardCountriesBody() {
  return Container(
    child: FutureBuilder(
      future: CovidDataSource.instance.loadCountries(),
      builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
          ) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.hasData) {
          CountriesModel countriesModel =
          CountriesModel.fromJson(snapshot.data);
          return _buildSuccessSection(countriesModel);
        }
        return _buildLoadingSection();
      },
    ),
  );
}

Widget _buildErrorSection() {
  return Text("Error");
}

Widget _buildEmptySection() {
  return Text("Empty");
}

Widget _buildLoadingSection() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildSuccessSection(CountriesModel data) {
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      itemCount: data.countries?.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blue[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:
              _buildItemCountries("${data.countries?[index].name} \n [${data.countries?[index].iso3}]"),
          ),
        ),
        );
      }
  );
}

Widget _buildItemCountries(String value) {
  return Text(value, textAlign: TextAlign.center,
    style: TextStyle(fontFamily: 'AkayaTelivigala',
        color: Colors.blueGrey[600],
        fontSize: 30,
        fontStyle: FontStyle.italic
    ),
  );
}






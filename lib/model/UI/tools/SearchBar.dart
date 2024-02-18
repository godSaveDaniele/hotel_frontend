import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/tools/WordCloud.dart';

import 'Communicator.dart';

class BarraDiRicerca extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CountrySearchDelegate());
            },
          ),
        ],
      ),
      body: Center(
          child: Communicator.sharedInstance.isCountry
              ? Communicator.sharedInstance.isMap
                  ? WordCloud(title: "Beautiful Presentation")
                  : CircularProgressIndicator()
              : Text('Clicca sul pulsante di ricerca per selezionare una nazione')
      ),
    );
  }
}


class CountrySearchDelegate extends SearchDelegate<String> {

  final List<String> countries = [
    'France',
    'United Kingdom',
    'Switzerland',
    'Germany',
    'Ireland',
    'United States of America',
    'Italy',
    'Spain',
    // Add more countries as needed
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear query button)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar (e.g., back button)
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on the query
    List<String> filteredCountries = [];
    if (query != "")
      filteredCountries.add(query);
    filteredCountries.addAll(countries
        .where((country) => country.toLowerCase().contains(query.toLowerCase()))
        .toList());


    return ListView.builder(
      itemCount: filteredCountries.length,
      itemBuilder: (BuildContext context, int index) {
        final String country = filteredCountries[index];
        return ListTile(
          title: Text(country),
          onTap: () {
            Communicator.sharedInstance.setCountry(country);
            close(context, country);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on the query (not implemented here)
    return Center(
      child: Text('Nessun suggerimento da mostrare'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/tools/WordCloud.dart';

import 'Communicator.dart';

class BarraDiRicerca extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    Communicator.sharedInstance.loadCountry();
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed:
            Communicator.sharedInstance.nationWordLoaded
            ? () { showSearch(context: context, delegate: CountrySearchDelegate()); }
            : null
          ),
        ],
      ),
      body: Center(
          child: Communicator.sharedInstance.nationWordLoaded
              ? Communicator.sharedInstance.nationReady
                ? WordCloud(title: "Beautiful Presentation")
                : Text('Click on search icon to select a country')
              : Center( child: CircularProgressIndicator( strokeWidth: 2, ), ),
      )
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
    'France',
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
    final List<String> filteredCountries = countries
        .where((country) => country.toLowerCase().contains(query.toLowerCase()))
        .toList();
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
      child: Text('No suggestions yet'),
    );
  }
}

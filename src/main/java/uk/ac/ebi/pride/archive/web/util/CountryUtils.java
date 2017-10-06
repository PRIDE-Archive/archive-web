package uk.ac.ebi.pride.archive.web.util;

import uk.ac.ebi.pride.archive.dataprovider.person.Country;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * This class may provide a list of countries.
 */
public final class CountryUtils {

  /**
   * Default constructor
   */
  private CountryUtils() {
  }

  /**
   * Get a list of countries without the UNKNOWN option. This list will be used by the title drop-down list.
   * @return A list of all countries.
   */
  public static List<Country> getValidCountries() {
    List<Country> countries = new ArrayList<>();
    for (Country country : Country.values()) {
      if (!country.equals(Country.UNKNOWN)) {
        countries.add(country);
      }
    }
    return countries;
  }

  /**
   * Get a list of countries with the UNKNOWN option. This list will be used by the title drop-down list.
   * @return A list of all countries.
   */
  public static List<String> getAllCountries() {
    return  Arrays.stream(Country.values()).sequential().map(Country::getCountry).collect(Collectors.toList());
  }
}

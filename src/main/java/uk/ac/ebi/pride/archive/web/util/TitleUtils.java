package uk.ac.ebi.pride.archive.web.util;

import uk.ac.ebi.pride.archive.dataprovider.person.Title;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Rui Wang
 * @version $Id$
 */
public final class TitleUtils {

    private TitleUtils() {
    }

    /**
     * Get a list of titles without the UNKNOWN option
     * This list will be used by the title drop-down list
     */
    public static List<Title> getValidTitles() {
        List<Title> titles = new ArrayList<Title>();
        for (Title title : Title.values()) {
            if (!title.equals(Title.UNKNOWN)) {
                titles.add(title);
            }
        }
        return titles;
    }
}

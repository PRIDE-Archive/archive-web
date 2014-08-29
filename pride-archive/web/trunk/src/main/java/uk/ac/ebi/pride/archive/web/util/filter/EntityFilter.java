package uk.ac.ebi.pride.archive.web.util.filter;

import java.util.Collection;

/**
 * Filter a list of entities
 *
 * @author Rui Wang
 * @version $Id$
 */
public interface  EntityFilter<T> {

    Collection<T> filter(Collection<T> entities);
}

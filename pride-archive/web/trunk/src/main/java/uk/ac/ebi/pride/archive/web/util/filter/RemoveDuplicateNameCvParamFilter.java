package uk.ac.ebi.pride.archive.web.util.filter;

import org.springframework.stereotype.Component;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * Remove cv param having the same values or names
 *
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class RemoveDuplicateNameCvParamFilter implements EntityFilter<CvParamSummary> {

    public RemoveDuplicateNameCvParamFilter() {
    }

    @Override
    public Collection<CvParamSummary> filter(Collection<CvParamSummary> cvParamSummaries) {

        if (cvParamSummaries != null) {
            Collection<CvParamSummary> filteredCvParamSummaries = new ArrayList<CvParamSummary>();
            Set<String> cvParamNames = new HashSet<String>();

            for (CvParamSummary cvParamSummary : cvParamSummaries) {
                String value = cvParamSummary.getValue();
                if (value != null) {
                    if (!cvParamNames.contains(value)) {
                        cvParamNames.add(value);
                        filteredCvParamSummaries.add(cvParamSummary);
                    }
                } else {
                    String name = cvParamSummary.getName();
                    if (!cvParamNames.contains(name)) {
                        cvParamNames.add(name);
                        filteredCvParamSummaries.add(cvParamSummary);
                    }
                }
            }
            return filteredCvParamSummaries;
        } else {
            return null;
        }

    }
}

package uk.ac.ebi.pride.archive.web.util;

import org.springframework.stereotype.Component;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;

import java.util.Comparator;
import java.util.Date;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class ProjectSummarySubmissionDateComparator implements Comparator<ProjectSummary>{

    public ProjectSummarySubmissionDateComparator() {
    }

    @Override
    public int compare(ProjectSummary p1, ProjectSummary p2) {
        Date p1SubmissionDate = p1.getSubmissionDate();
        Date p2SubmissionDate = p2.getSubmissionDate();

        return p2SubmissionDate.compareTo(p1SubmissionDate);
    }
}

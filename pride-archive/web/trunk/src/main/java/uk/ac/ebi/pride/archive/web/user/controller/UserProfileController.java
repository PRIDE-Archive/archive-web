package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.ProjectSummarySubmissionDateComparator;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;


/**
 * Controller for viewing user profile
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/users/profile")
public class UserProfileController extends AbstractUserProfileController{

    public static final Logger logger = LoggerFactory.getLogger(UserProfileController.class);

    @Autowired
    private ProjectSummarySubmissionDateComparator projectSummarySubmissionDateComparator;


    @RequestMapping(method = RequestMethod.GET)
    @PreAuthorize("hasRole('ADMINISTRATOR', 'REVIEWER', 'SUBMITTER')")
    public ModelAndView getUserProfile(Principal principal) {
        // get current user details
        UserSummary user = userSecureReadOnlyService.findByEmail(principal.getName());

        // get all the projects belong to the user
        Collection<ProjectSummary> projectSummaries = userSecureReadOnlyService.findAllProjectsById(user.getId());

        projectSummaries = sortProjectSummaries(projectSummaries);

        // display user profile page
        return pageMaker.createUserProfilePage(user, projectSummaries);
    }

    private Collection<ProjectSummary> sortProjectSummaries(Collection<ProjectSummary> projectSummaries) {
        if (projectSummaries == null || projectSummaries.isEmpty()) {
            return projectSummaries;
        } else {
            List<ProjectSummary> projectSummaryList = new ArrayList<ProjectSummary>();
            projectSummaryList.addAll(projectSummaries);
            Collections.sort(projectSummaryList, projectSummarySubmissionDateComparator);
            return projectSummaryList;
        }
    }


}

package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.user.model.ChangePassword;
import uk.ac.ebi.pride.archive.web.user.model.UpdateUserSummary;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;

import java.security.Principal;

/**
 * Controller for editing user profile
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
public class UserProfileEditController extends AbstractUserProfileController {
    private static final Logger logger = LoggerFactory.getLogger(UserProfileEditController.class);

    @RequestMapping(value = "/users/profile/edit", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ADMINISTRATOR', 'REVIEWER', 'SUBMITTER')")
    public ModelAndView getUserProfile(Principal principal) {
        UserSummary user = userSecureReadOnlyService.findByEmail(principal.getName());

        return pageMaker.createEditUserProfilePage(new UpdateUserSummary(user), new ChangePassword(user.getEmail()), false, false);
    }
}

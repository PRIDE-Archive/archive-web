package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.web.user.model.ChangePassword;
import uk.ac.ebi.pride.archive.web.user.model.UpdateUserSummary;
import uk.ac.ebi.pride.archive.web.user.validator.ChangePasswordValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.validation.Valid;
import java.security.Principal;

/**
 * Controller to change a user's password
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/users/profile/changepassword")
public class UserProfileChangePasswordController extends AbstractUserProfileController {

    private static final Logger logger = LoggerFactory.getLogger(UserProfileChangePasswordController.class);

    @Autowired
    private ChangePasswordValidator changePasswordValidator;

    @Autowired
    private PrideSupportEmailSender prideSupportEmailSender;

    @Autowired
    private String passwordChangeEmailTemplate;

    @InitBinder(value = "updatePassword")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(changePasswordValidator);
    }


    @RequestMapping(method = RequestMethod.POST)
    @PreAuthorize("hasRole('ADMINISTRATOR', 'REVIEWER', 'SUBMITTER')")
    public ModelAndView requestUpdateUserProfile(@ModelAttribute("updatePassword") @Valid ChangePassword changePassword,
                                           BindingResult errors,
                                           Principal principal) {
        UserSummary originalUser = userSecureReadOnlyService.findByEmail(principal.getName());

        if (errors.hasErrors()) {
            // return to the initial edit user profile page
            return pageMaker.createEditUserProfilePage(new UpdateUserSummary(originalUser), changePassword, false, false);
        } else {
            originalUser.setPassword(changePassword.getOldPassword());

            try {
                UpdateUserSummary updateContact = new UpdateUserSummary(originalUser);
                updateContact.setPassword(changePassword.getNewPassword());

                // update contact details
                userSecureServiceWebService.update(originalUser, updateContact);

                prideSupportEmailSender.sendPasswordChangeEmail(updateContact, passwordChangeEmailTemplate);
            } catch (Exception ex) {
                logger.error("Failed to update user contact details", ex);

                return pageMaker.createEditUserProfilePage(new UpdateUserSummary(originalUser), new ChangePassword(principal.getName()), false, true);
            }

            return new ModelAndView(new RedirectView("/users/profile", true));
        }
    }
}

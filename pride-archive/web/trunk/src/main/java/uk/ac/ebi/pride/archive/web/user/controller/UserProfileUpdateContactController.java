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
import uk.ac.ebi.pride.archive.web.user.validator.UpdateUserSummaryValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.security.Principal;

/**
 * Controller to update user contact details, including email
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/users/profile/editcontact")
public class UserProfileUpdateContactController extends AbstractUserProfileController {

    private static final Logger logger = LoggerFactory.getLogger(UserProfileEditController.class);

    @Autowired
    private UpdateUserSummaryValidator updateUserSummaryValidator;

    @Autowired
    private PrideSupportEmailSender prideSupportEmailSender;

    @Autowired
    private String emailAddressChangeEmailTemplate;

    @InitBinder(value = "updateContact")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(updateUserSummaryValidator);
    }

    @RequestMapping(method = RequestMethod.POST)
    @PreAuthorize("hasRole('ADMINISTRATOR', 'REVIEWER', 'SUBMITTER')")
    public ModelAndView requestUpdateUserProfile(@ModelAttribute("updateContact") @Valid UpdateUserSummary updatedContact,
                                           BindingResult errors,
                                           Principal principal) {

        if (errors.hasErrors()) {
            // return to the initial edit user profile page
            return pageMaker.createEditUserProfilePage(updatedContact, new ChangePassword(principal.getName()), false, false);
        } else {
            // redirect to re-enter password page
            return pageMaker.createEnterOldPasswordPage(updatedContact);
        }
    }


    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @PreAuthorize("hasRole('ADMINISTRATOR', 'REVIEWER', 'SUBMITTER')")
    public ModelAndView updateUserProfile(@ModelAttribute("updateContact") @Valid UpdateUserSummary updateContact,
                                    BindingResult errors,
                                    HttpServletRequest request,
                                    Principal principal) {

        if (errors.hasErrors()) {
            return pageMaker.createEnterOldPasswordPage(updateContact);
        } else {
            UserSummary originalUser = userSecureReadOnlyService.findByEmail(principal.getName());
            String existingPassword = updateContact.getExistingPassword();
            originalUser.setPassword(existingPassword);
            updateContact.setPassword(existingPassword);

            String oldEmail = originalUser.getEmail();

            try {
                // update contact details
                userSecureServiceWebService.update(originalUser, updateContact);

                // send a notification email if email address changed
                if (!oldEmail.equalsIgnoreCase(updateContact.getEmail())) {
                    prideSupportEmailSender.sendEmailChangeEmail(updateContact, oldEmail, emailAddressChangeEmailTemplate);
                }
            } catch (Exception ex) {
                logger.error("Failed to update user contact details", ex);
                return pageMaker.createEditUserProfilePage(updateContact, new ChangePassword(principal.getName()), true, false);
            }

            doAutoLogin(updateContact.getEmail(), updateContact.getPassword(), request);

            return new ModelAndView(new RedirectView("/users/profile", true));
        }
    }

}

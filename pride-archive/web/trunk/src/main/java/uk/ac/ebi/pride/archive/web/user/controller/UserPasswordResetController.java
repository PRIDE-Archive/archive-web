package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import uk.ac.ebi.pride.archive.web.user.validator.UserPasswordResetValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.validation.Valid;

/**
 * Controller for resetting a user's password
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/users/forgotpassword")
public class UserPasswordResetController extends AbstractUserProfileController{
    public static final Logger logger = LoggerFactory.getLogger(UserPasswordResetController.class);

    @Autowired
    private PrideSupportEmailSender mailSender;

    @Autowired
    private String passwordResetEmailTemplate;

    @Autowired
    private UserPasswordResetValidator userPasswordResetValidator;

    @InitBinder(value = "user")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(userPasswordResetValidator);
    }


    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView resetPassword() {
        return pageMaker.createForgotPasswordPage(new UserSummary(), false);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView resetPassword(@ModelAttribute("user") @Valid UserSummary user, BindingResult results) {

        if (results.hasErrors()) {
            return pageMaker.createForgotPasswordPage(user, false);
        } else {
            try {
                UserSummary resetUser = userSecureServiceWebService.resetPassword(user.getEmail());
                mailSender.sendPasswordResetEmail(resetUser, passwordResetEmailTemplate);
            } catch (Exception ex) {
                logger.error("Failed to reset user's password: " + user.getEmail(), ex);

                return pageMaker.createForgotPasswordPage(user, true);
            }

            return new ModelAndView(new RedirectView("/passwordReset", true));
        }
    }
}

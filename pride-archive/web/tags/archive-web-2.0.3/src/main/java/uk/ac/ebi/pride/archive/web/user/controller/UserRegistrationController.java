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
import uk.ac.ebi.pride.archive.repo.user.PasswordUtilities;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.web.user.validator.UserRegistrationValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * Controller to register a new user
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/register")
public class UserRegistrationController extends AbstractUserProfileController{
    private static final Logger logger = LoggerFactory.getLogger(UserRegistrationController.class);

    @Autowired
    private UserRegistrationValidator userRegistrationValidator;

    @Autowired
    private PrideSupportEmailSender prideSupportEmailSender;

    @Autowired
    private String registrationEmailTemplate;

    @InitBinder(value = "user")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(userRegistrationValidator);
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView register() {
        return pageMaker.createRegistrationPage(new UserSummary(), false);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView processRegistrationSubmit(@ModelAttribute(value = "user") @Valid UserSummary user, BindingResult errors, HttpServletRequest request) {

        if (errors.hasErrors()) {
            return pageMaker.createRegistrationPage(user, false);
        } else {
            try {
                String password = PasswordUtilities.generatePassword();
                user.setPassword(password);
                userSecureServiceWebService.signUp(user);

                // send registration success email
                prideSupportEmailSender.sendRegistrationEmail(user, password, registrationEmailTemplate);
            } catch (Exception ex) {
                logger.error("Failed to register new user", ex);
                return pageMaker.createRegistrationPage(user, false);
            }

            return pageMaker.createRegistrationSuccessfulPage(user);
        }
    }
}

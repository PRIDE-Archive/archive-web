package uk.ac.ebi.pride.archive.web.user.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import uk.ac.ebi.pride.archive.repo.user.service.UserService;
import uk.ac.ebi.pride.archive.repo.user.service.validation.UserSummaryValidator;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class UserPasswordResetValidator extends UserSummaryValidator {
    public static final String EMAIL_NOT_EXIST_ERROR_MESSAGE = "Email address not exist";

    @Autowired
    public UserPasswordResetValidator(UserService userServiceImpl) {
        super(userServiceImpl);
    }

    @Override
    public void validate(Object target, Errors errors) {
        rejectIllegalEmail(errors, EMAIL_ERROR_MESSAGE);
        if (!errors.hasErrors()) {
            rejectNoneExistingEmail(errors, EMAIL_NOT_EXIST_ERROR_MESSAGE);
        }
    }
}

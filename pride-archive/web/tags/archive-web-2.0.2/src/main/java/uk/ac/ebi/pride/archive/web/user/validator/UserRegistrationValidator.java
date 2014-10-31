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
public class UserRegistrationValidator extends UserSummaryValidator {

    @Autowired
    public UserRegistrationValidator(UserService userServiceImpl) {
        super(userServiceImpl);
    }

    @Override
    public void validate(Object target, Errors errors) {
        validateContactDetails(target, errors);
        validateEmail(target, errors);
    }
}

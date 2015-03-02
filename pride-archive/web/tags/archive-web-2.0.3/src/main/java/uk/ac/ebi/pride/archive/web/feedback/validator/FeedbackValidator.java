package uk.ac.ebi.pride.archive.web.feedback.validator;


import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import uk.ac.ebi.pride.archive.web.feedback.model.Feedback;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class FeedbackValidator implements Validator {

    public static final String FEEDBACK_ERROR_MESSAGE = "Please provide your comments";

    @Override
    public boolean supports(Class<?> clazz) {
        return Feedback.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "comment", "required", FEEDBACK_ERROR_MESSAGE);
    }
}

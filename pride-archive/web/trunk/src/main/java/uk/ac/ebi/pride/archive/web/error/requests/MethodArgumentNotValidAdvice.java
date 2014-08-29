package uk.ac.ebi.pride.archive.web.error.requests;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

/**
 * @author Jose A. Dianes
 * @version $Id$
 *
 * todo: move error message to external file
 */
@ControllerAdvice
public class MethodArgumentNotValidAdvice {

    private static final Logger logger = LoggerFactory.getLogger(MethodArgumentNotValidAdvice.class);

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ModelAndView handleMethodArgumentNotValidException(MethodArgumentNotValidException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = "Request error";
        String errorMessage = "Cause: " + ex.getMessage() + ".";
        String errorAdvice = "Try again with a different set of request parameters";
        return pageMaker.createErrorPage(errorTitle, errorMessage, errorAdvice);
    }

}

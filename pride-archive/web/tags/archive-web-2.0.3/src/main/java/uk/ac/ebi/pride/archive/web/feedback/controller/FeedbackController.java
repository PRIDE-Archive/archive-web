package uk.ac.ebi.pride.archive.web.feedback.controller;

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
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.web.feedback.model.Feedback;
import uk.ac.ebi.pride.archive.web.feedback.validator.FeedbackValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.validation.Valid;

/**
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/feedback")
public class FeedbackController {
    public static final Logger logger = LoggerFactory.getLogger(FeedbackController.class);

    @Autowired
    private PrideSupportEmailSender prideSupportEmailSender;

    @Autowired
    private FeedbackValidator feedbackValidator;

    @Autowired
    private String feedbackEmailTemplate;

    @Autowired
    private PageMaker pageMaker;

    @InitBinder(value = "feedback")
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(feedbackValidator);
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView writeFeedback() {
        return pageMaker.createFeedbackPage(new Feedback());
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView sendFeedback(@ModelAttribute("feedback") @Valid Feedback feedback, BindingResult errors) {
        if (errors.hasErrors()) {
            return pageMaker.createFeedbackPage(feedback);
        } else {
            prideSupportEmailSender.sendFeedbackEmail(feedback, feedbackEmailTemplate);
            return pageMaker.createFeedbackAcknowledgementPage();
        }
    }
}

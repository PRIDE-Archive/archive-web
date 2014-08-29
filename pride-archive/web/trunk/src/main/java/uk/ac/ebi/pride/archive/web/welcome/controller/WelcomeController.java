package uk.ac.ebi.pride.archive.web.welcome.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.repo.statistics.service.StatisticsService;
import uk.ac.ebi.pride.archive.repo.statistics.service.StatisticsSummary;
import uk.ac.ebi.pride.web.util.twitter.TwitterService;

import java.util.Collections;
import java.util.List;

/**
 * @author Rui Wang
 * @author Jose A. Dianes
 * @version $Id$
 */
@Controller
public class WelcomeController {

    private static final Logger logger = LoggerFactory.getLogger(WelcomeController.class);

    private static final int DEFAULT_NUMBER_OF_TWEETS = 20;

    @Autowired
    private StatisticsService statisticsServiceImpl;

    @Autowired
    private TwitterService twitterService;

    @Autowired
    private PageMaker pageMaker;

    @Value("#{socialConfig['twitter.num.tweets.to.show']}")
    private int numOfTweetsToShow;

    @RequestMapping( value = "/", method = RequestMethod.GET )
    public ModelAndView welcomePage() {

        // get statistics
        StatisticsSummary statisticsSummary;
        try {
            statisticsSummary = statisticsServiceImpl.getLatestStatistics();
        } catch (Exception e) {
            logger.error("Error retrieving statistics!", e);
            // ToDo: perhaps set some default
            statisticsSummary = new StatisticsSummary();
        }

        // get tweets
        List<Tweet> tweets;

        try {
            // retrieve tweets from Twitter
            tweets = twitterService.queryForTweets(DEFAULT_NUMBER_OF_TWEETS);

            // limit the tweets to the pre-defined number we want to show on the page
            tweets = tweets.size() < numOfTweetsToShow ? tweets : tweets.subList(0, numOfTweetsToShow);
        } catch (Exception e) {
            logger.error("Caught unexpected error while retrieving Twitter items!", e);
            tweets = Collections.emptyList();
        }

        return pageMaker.createWelcomePage(statisticsSummary, tweets);
    }


}

package uk.ac.ebi.pride.archive.web.check.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

import javax.sql.DataSource;
import java.sql.*;

/**
 * @author Florian Reisinger
 * @since 1.0.4
 */
@Controller
public class CheckController {

    private static final Logger logger = LoggerFactory.getLogger(CheckController.class);

    @Autowired
    private PageMaker pageMaker;

    @Autowired
    private DataSource prideDataSource;


    @RequestMapping( value = "/check", method = RequestMethod.GET )
    public ModelAndView webCheckPage() {
        boolean ok;
        StringBuilder report = new StringBuilder();
        Connection connection = null;
        try {
            connection = prideDataSource.getConnection();
            DatabaseMetaData metaData = connection.getMetaData();
            ok = !connection.isClosed(); // after retrieving of the meta-data we should have a working connection!
            report.append("Connected database:").append(metaData.getDatabaseProductName()).append("\n");
            report.append("Driver version:").append(metaData.getDriverVersion()).append("\n");
            PreparedStatement statement = connection.prepareStatement("SELECT count(*) FROM project");
            ResultSet result = statement.executeQuery();
            result.next();
            int projectCount = result.getInt(1);
            report.append("Current number of projects: ").append(projectCount);
        } catch (SQLException e) {
            logger.error("Exception trying to test DB connection.", e);
            ok = false;
            report.append(e.getErrorCode());
            report.append(e.getMessage());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    logger.error("Failed to close connection!", e);
                }
            }
        }

        return pageMaker.createWebCheckPage(ok, report.toString());
    }



}

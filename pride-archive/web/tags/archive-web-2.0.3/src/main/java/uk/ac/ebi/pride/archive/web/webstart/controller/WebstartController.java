package uk.ac.ebi.pride.archive.web.webstart.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import uk.ac.ebi.pride.archive.web.error.webstart.InspectorTemplateException;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

/**
 * @author Rui Wang
 * @version $Id$
 *
 */
@Controller
public class WebstartController {
    private static final Logger logger = LoggerFactory.getLogger(WebstartController.class);

    private enum AccessionType {PROJECT, ASSAY}

    private static final String PLACEHOLDER = "Insert Arguments";

    @Value("#{config['jnlp.file.url']}")
    private String jnlpFileURL;

    @RequestMapping(value = "/projects/{projectAccession}/jnlp", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public void getProjectJNLP(@PathVariable("projectAccession") String projectAccession, HttpServletResponse response) throws InspectorTemplateException {
        getJNLP(projectAccession, AccessionType.PROJECT, response);
    }

    @RequestMapping(value = "/assays/{assayAccession}/jnlp", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public void getAssayJNLP(@PathVariable("assayAccession") String assayAccession, HttpServletResponse response) throws InspectorTemplateException {
        getJNLP(assayAccession, AccessionType.ASSAY, response);
    }

    private void getJNLP(String accession, AccessionType accessionType, HttpServletResponse response) throws InspectorTemplateException {
        try {
            String jnlpFileString = makeJNLPFile(accession, accessionType);
            writeOutJNLPFile(jnlpFileString, response);
        } catch (IOException e) {
            String msg = "Failed to read the PRIDE Inspector webstart file from PRIDE";
            logger.error(msg, e);
            throw new InspectorTemplateException(msg, e);
        }
    }

    private void writeOutJNLPFile(String jnlpFileString, HttpServletResponse response) throws IOException {
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        response.setContentType("application/x-java-jnlp-file");
        response.setHeader("Content-Disposition", "attachment; filename=pride-inspector.jnlp");
        response.setHeader("Content-Length", "" + jnlpFileString.length());
        response.getWriter().println(jnlpFileString);
    }

    private String makeJNLPFile(String accession, AccessionType accessionType) throws IOException {
        URL jnlpURL = new URL(jnlpFileURL);
        logger.info("JNLP URL: " + jnlpURL.toString());

        StringBuilder jnlp = new StringBuilder();

        BufferedReader in = new BufferedReader(new InputStreamReader(jnlpURL.openStream()));

        String line;
        while ((line = in.readLine()) != null) {
            jnlp.append(line);
            jnlp.append("\n");

            if (line.contains(PLACEHOLDER)) {
                jnlp.append("        <argument>");

                if (accessionType.equals(AccessionType.PROJECT)) {
                    jnlp.append("--project=");
                } else if (accessionType.equals(AccessionType.ASSAY)) {
                    jnlp.append("--assay=");
                }

                jnlp.append(accession);
                jnlp.append("</argument>\n");
            }
        }
        in.close();

        return jnlp.toString();
    }
}

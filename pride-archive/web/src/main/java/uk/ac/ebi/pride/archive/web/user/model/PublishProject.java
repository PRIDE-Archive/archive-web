package uk.ac.ebi.pride.archive.web.user.model;

/**
 * @author Rui Wang
 * @version $Id$
 */
public class PublishProject {
    private String pubmedId;
    private String doi;
    private String referenceLine;

    public PublishProject() {
    }

    public String getPubmedId() {
        return pubmedId;
    }

    public void setPubmedId(String pubmedId) {
        this.pubmedId = pubmedId;
    }

    public String getDoi() {
        return doi;
    }

    public void setDoi(String doi) {
        this.doi = doi;
    }

    public String getReferenceLine() {
        return referenceLine;
    }

    public void setReferenceLine(String referenceLine) {
        this.referenceLine = referenceLine;
    }
}

package uk.ac.ebi.pride.archive.web.model;

import java.util.TreeSet;


/**
 * Created by tobias on 16/04/2015.
 */
public class QualityAwarePsms {
    private TreeSet<QualityAwarePsm> qualityAwarePsms;

    public String toString() {
        String result = "";
        for (QualityAwarePsm qualityAwarePsm : qualityAwarePsms) {
            result += qualityAwarePsm.toString() + "\n";
        }
        return result;
    }

    public TreeSet<QualityAwarePsm> getQualityAwarePsms() {
        return this.qualityAwarePsms;
    }

}

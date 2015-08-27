package uk.ac.ebi.pride.archive.web.model;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * Created by tobias on 16/04/2015.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class QualityAwarePsm implements Comparable<QualityAwarePsm>{

    enum Quality {
        HIGH(1), MEDIUM(0), LOW(-1);
        private int value;

        Quality(int value) {
            this.value = value;
        }
    }

    private String clusterId, clusterQuality;

    public QualityAwarePsm() {
        clusterId = "";
        clusterQuality = "";
    }

    public String toString() {
        return clusterId + " " + clusterQuality;
    }

    @Override
    public int compareTo(QualityAwarePsm o) {
        return Quality.valueOf(o.getClusterQuality()).value - Quality.valueOf(this.clusterQuality).value;
    }

    public String getClusterQuality() {
        return this.clusterQuality;
    }

    public String getClusterId() {
        return this.clusterId;
    }
}

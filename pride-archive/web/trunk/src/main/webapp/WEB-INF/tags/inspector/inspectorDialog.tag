<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="accession" required="true" %>


<div id="inspector-dialog" title="Open in PRIDE Inspector">
    Follow the next three steps to open your selected project or assay in PRIDE Inspector:
    <br/>
    <br/>
    <ul style="list-style-type: none">
        <li>
            <h3 style="display: inline">1.</h3>
            Download, uncompress and open PRIDE Inspector <img id="inspector-img" style="width: 45px;" src="${pageContext.request.contextPath}/resources/img/inspectorIcon.png" />

        </li>
        <li>
            <h3 style="display: inline">2.</h3>
            Click in the magnifier <img style="height: 20px" src="${pageContext.request.contextPath}/resources/img/search.png"> on the left top corner, paste the project or assay
            that you would like to open in the search box,
            <label>
            in this case <input size="10" style="text-align: center" title="Select the text and copy it (e.g. Ctr+C or Cmd+C)" type="text" value="${accession}" onfocus="this.setSelectionRange(0, this.value.length)" />,
            </label> and hit search
        </li>
        <li>
            <h3 style="display: inline">3.</h3>
            Click in the corresponding "Download" button to download the files and visualize them
        </li>
    </ul>

    <div style="text-align: right" >
        <span>PRIDE Inspector documentation <a href="https://github.com/PRIDE-Toolsuite/pride-inspector">here </a></span>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#inspector-dialog").dialog({
            autoOpen: false,
            height: 390,
            width: 630,
            modal: true,
            buttons: {
                "Download": function () {
                    window.open('http://www.ebi.ac.uk/pride/resources/tools/inspector/latest/desktop/pride-inspector.zip', '_blank');
                    $(this).dialog("close");
                }
            }
        });

        $("#inspector-confirm").click(function () {
            $("#inspector-dialog").dialog("open");
        });
    });
</script>

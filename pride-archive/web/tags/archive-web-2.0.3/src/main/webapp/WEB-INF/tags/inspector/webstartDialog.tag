<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="prideInspectorUrl" required="true" %>

<a id="pride-inspector-url" href="${prideInspectorUrl}"></a>

<div id="inspector-dialog" title="Launch PRIDE Inspector">
    <p>
        <fmt:message key="inspector.web.start.dialog.header"/>
    </p>

    <p>
        <fmt:message key="inspector.web.start.dialog.warning"/>
    </p>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#inspector-dialog").dialog({
            autoOpen: false,
            height: 300,
            width: 600,
            modal: true,
            buttons: {
                "Launch": function () {
                    var url = $('#pride-inspector-url').attr('href');
                    window.open(url, '_blank');
                    $(this).dialog("close");
                },

                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#inspector-confirm").click(function () {
            $("#inspector-dialog").dialog("open");
        });
    });
</script>
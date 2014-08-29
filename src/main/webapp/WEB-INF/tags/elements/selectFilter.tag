<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="id" required="true"%>
<%@ attribute name="items" required="true" type="java.util.Map" %>
<%@ attribute name="name" required="true" %>
<select id="${id}" name="${name}" style="overflow:hidden; max-width:150px; display:none;">
    <option value="" selected>-Any-</option>
    <c:forEach var="theItem" items="${items}">
        <c:if test="${theItem.value > 0}">
            <option value="${theItem.key}">${theItem.key} (${theItem.value})</option>
        </c:if>
    </c:forEach>
</select>

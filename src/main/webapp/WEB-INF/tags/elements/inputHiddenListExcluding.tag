<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="items" required="true" type="java.util.Collection" %>
<%@ attribute name="name" required="true" %>
<%@ attribute name="excludeItem" required="true" %>
<c:forEach var="theItem" items="${items}">
    <c:if test="${theItem!=excludeItem}"><input type='hidden' name='${name}' value='${theItem}'/></c:if>
</c:forEach>

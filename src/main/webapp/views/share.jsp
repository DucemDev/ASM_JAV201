<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<h3 class="mb-4">📤 Chia sẻ quán ăn</h3>

<form method="post"
      action="<c:url value='/share-send' />">

    <input type="hidden"
           name="restaurantId"
           value="${param.id}" />

    <div class="mb-3">
        <label>Email</label>
        <input type="email"
               name="email"
               required />
    </div>

    <button type="submit">Send</button>
</form>

<%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>Student List</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 1100px;
        margin: 30px auto;
        background: white;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 0 10px #cccccc;
    }

    h2 {
        text-align: center;
        color: #2c3e50;
    }

    .add-button {
        display: inline-block;
        background-color: #28a745;
        color: white;
        padding: 10px 15px;
        text-decoration: none;
        border-radius: 5px;
        margin-bottom: 15px;
    }

    .search-form {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        margin: 10px 0 25px;
    }

    .search-input {
        flex: 1;
        min-width: 220px;
        padding: 11px;
        border: 1px solid #cccccc;
        border-radius: 5px;
    }

    .search-button {
        background-color: #007bff;
        color: white;
        padding: 10px 18px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .reset-button {
        display: inline-block;
        background-color: #6c757d;
        color: white;
        padding: 10px 15px;
        text-decoration: none;
        border-radius: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #dddddd;
        padding: 12px;
        text-align: left;
        overflow-wrap: anywhere;
    }

    th {
        background-color: #007bff;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .edit-button {
        display: inline-block;
        background-color: #ffc107;
        color: black;
        padding: 6px 10px;
        text-decoration: none;
        border-radius: 4px;
        margin-bottom: 5px;
    }

    .delete-button {
        background-color: #dc3545;
        color: white;
        padding: 7px 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .home-link {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
    }

    .empty-message {
        text-align: center;
        padding: 20px;
        color: #666666;
    }

    .result-message {
        color: #555555;
        margin-bottom: 15px;
    }

    @media (max-width: 700px) {
        .container {
            padding: 12px;
            overflow-x: auto;
        }

        table {
            min-width: 700px;
        }
    }
</style>
```

</head>

<body>

<div class="container">

```
<h2>Student Management System</h2>

<a class="add-button"
   href="${pageContext.request.contextPath}/students/new">
    + Add New Student
</a>

<!-- Search students by name or email -->
<form class="search-form"
      action="${pageContext.request.contextPath}/students/search"
      method="get">

    <input class="search-input"
           type="text"
           name="keyword"
           value="<c:out value='${keyword}'/>"
           placeholder="Search by student name or email"
           maxlength="150"
           aria-label="Search by student name or email">

    <button class="search-button" type="submit">
        Search
    </button>

    <a class="reset-button"
       href="${pageContext.request.contextPath}/students">
        Show All
    </a>

</form>

<c:if test="${not empty keyword}">
    <p class="result-message">
        Search results for:
        <strong><c:out value="${keyword}"/></strong>
    </p>
</c:if>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Course</th>
            <th>Fees</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>

        <c:choose>

            <c:when test="${empty students}">
                <tr>
                    <td colspan="6" class="empty-message">
                        No students found.
                        Try another search or register a student.
                    </td>
                </tr>
            </c:when>

            <c:otherwise>

                <c:forEach var="student" items="${students}">

                    <tr>
                        <td>
                            <c:out value="${student.id}"/>
                        </td>

                        <td>
                            <c:out value="${student.name}"/>
                        </td>

                        <td>
                            <c:out value="${student.email}"/>
                        </td>

                        <td>
                            <c:out value="${student.course}"/>
                        </td>

                        <td>
                            ₹ <c:out value="${student.fees}"/>
                        </td>

                        <td>
                            <a class="edit-button"
                               href="${pageContext.request.contextPath}/students/edit/${student.id}">
                                Edit
                            </a>

                            <form action="${pageContext.request.contextPath}/students/delete/${student.id}"
                                  method="post"
                                  style="display:inline;"
                                  onsubmit="return confirm('Are you sure you want to delete this student?');">

                                <button class="delete-button" type="submit">
                                    Delete
                                </button>

                            </form>
                        </td>
                    </tr>

                </c:forEach>

            </c:otherwise>

        </c:choose>

    </tbody>
</table>

<a class="home-link"
   href="${pageContext.request.contextPath}/">
    Back to Home
</a>


</div>

</body>
</html>

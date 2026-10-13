<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>

    <style>
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

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #dddddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .edit-button {
            background-color: #ffc107;
            color: black;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 4px;
        }

        .delete-button {
            background-color: #dc3545;
            color: white;
            padding: 6px 10px;
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
    </style>
</head>

<body>

<div class="container">

    <h2>Student Management System</h2>

    <a class="add-button"
       href="${pageContext.request.contextPath}/students/new">
        + Add New Student
    </a>

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
                            No students found. Please register a student.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>

                    <c:forEach var="student" items="${students}">

                        <tr>
                            <td><c:out value="${student.id}" /></td>

                            <td><c:out value="${student.name}" /></td>

                            <td><c:out value="${student.email}" /></td>

                            <td><c:out value="${student.course}" /></td>

                            <td><c:out value="${student.fees}" /></td>

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
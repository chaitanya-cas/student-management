<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Management System</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 25px auto;
            padding: 25px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 12px #ddd;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
        }

        .add-button {
            display: inline-block;
            background: #28a745;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .filters {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
            margin: 15px 0;
        }

        .filters input,
        .filters select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            min-width: 130px;
        }

        .filters input[name="keyword"] {
            flex: 1;
            min-width: 200px;
        }

        .search-button {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .reset-button {
            background: #6c757d;
            color: white;
            padding: 10px 14px;
            text-decoration: none;
            border-radius: 5px;
        }

        .summary {
            margin: 20px 0;
            color: #444;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background: #f7f9fc;
        }

        .edit-button {
            display: inline-block;
            background: #ffc107;
            color: #222;
            padding: 7px 10px;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 5px;
        }

        .delete-button {
            background: #dc3545;
            color: white;
            border: none;
            padding: 7px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .empty-message {
            text-align: center;
            padding: 25px;
            color: #666;
        }

        .pagination {
            display: flex;
            flex-wrap: wrap;
            gap: 7px;
            align-items: center;
            justify-content: center;
            margin: 25px 0;
        }

        .pagination a,
        .pagination span {
            display: inline-block;
            padding: 9px 13px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #007bff;
            background: white;
        }

        .pagination .active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination .disabled {
            color: #999;
            background: #eee;
        }

        .home-link {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
        }

        @media (max-width: 600px) {
            .container {
                padding: 12px;
            }

            .filters {
                align-items: stretch;
                flex-direction: column;
            }

            .filters input,
            .filters select,
            .filters button {
                width: 100%;
            }
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

    <!-- Search, sorting and page-size form -->
    <form class="filters"
          action="${pageContext.request.contextPath}/students"
          method="get">

        <input type="text"
               name="keyword"
               value="<c:out value='${keyword}'/>"
               placeholder="Search name or email"
               maxlength="150"
               aria-label="Search name or email">

        <select name="sortBy" aria-label="Sort field">
            <option value="id"
                <c:if test="${sortBy == 'id'}">selected</c:if>>
                Sort by ID
            </option>

            <option value="name"
                <c:if test="${sortBy == 'name'}">selected</c:if>>
                Sort by Name
            </option>

            <option value="email"
                <c:if test="${sortBy == 'email'}">selected</c:if>>
                Sort by Email
            </option>

            <option value="course"
                <c:if test="${sortBy == 'course'}">selected</c:if>>
                Sort by Course
            </option>

            <option value="fees"
                <c:if test="${sortBy == 'fees'}">selected</c:if>>
                Sort by Fees
            </option>
        </select>

        <select name="direction" aria-label="Sort direction">
            <option value="asc"
                <c:if test="${direction == 'asc'}">selected</c:if>>
                Ascending
            </option>

            <option value="desc"
                <c:if test="${direction == 'desc'}">selected</c:if>>
                Descending
            </option>
        </select>

        <select name="size" aria-label="Students per page">
            <option value="5"
                <c:if test="${size == 5}">selected</c:if>>
                5 per page
            </option>

            <option value="10"
                <c:if test="${size == 10}">selected</c:if>>
                10 per page
            </option>

            <option value="20"
                <c:if test="${size == 20}">selected</c:if>>
                20 per page
            </option>
        </select>

        <button class="search-button" type="submit">
            Apply
        </button>

        <a class="reset-button"
           href="${pageContext.request.contextPath}/students">
            Reset
        </a>

    </form>

    <!-- Student count -->
    <div class="summary">

        <c:choose>
            <c:when test="${not empty keyword}">
                Search results for:
                <strong><c:out value="${keyword}"/></strong>
                |
            </c:when>
        </c:choose>

        Total matching students:
        <strong><c:out value="${totalItems}"/></strong>

        |
        Page:
        <strong>
            <c:choose>
                <c:when test="${totalPages > 0}">
                    ${currentPage + 1} of ${totalPages}
                </c:when>
                <c:otherwise>0 of 0</c:otherwise>
            </c:choose>
        </strong>

    </div>

    <!-- Student table -->
    <div class="table-wrapper">

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

                                    <form
                                        action="${pageContext.request.contextPath}/students/delete/${student.id}"
                                        method="post"
                                        style="display:inline;"
                                        onsubmit="return confirm('Are you sure you want to delete this student?');">

                                        <button class="delete-button"
                                                type="submit">
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

    </div>

    <!-- Pagination -->
    <c:if test="${totalPages > 1}">

        <div class="pagination">

            <!-- Previous page -->
            <c:choose>

                <c:when test="${currentPage > 0}">
                    <c:url var="previousUrl" value="/students">
                        <c:param name="page" value="${currentPage - 1}"/>
                        <c:param name="size" value="${size}"/>
                        <c:param name="sortBy" value="${sortBy}"/>
                        <c:param name="direction" value="${direction}"/>
                        <c:param name="keyword" value="${keyword}"/>
                    </c:url>

                    <a href="${previousUrl}">Previous</a>
                </c:when>

                <c:otherwise>
                    <span class="disabled">Previous</span>
                </c:otherwise>

            </c:choose>

            <!-- Numbered pages -->
            <c:forEach begin="0" end="${totalPages - 1}" var="i">

                <c:choose>

                    <c:when test="${i == currentPage}">
                        <span class="active">${i + 1}</span>
                    </c:when>

                    <c:otherwise>

                        <c:url var="pageUrl" value="/students">
                            <c:param name="page" value="${i}"/>
                            <c:param name="size" value="${size}"/>
                            <c:param name="sortBy" value="${sortBy}"/>
                            <c:param name="direction" value="${direction}"/>
                            <c:param name="keyword" value="${keyword}"/>
                        </c:url>

                        <a href="${pageUrl}">${i + 1}</a>

                    </c:otherwise>

                </c:choose>

            </c:forEach>

            <!-- Next page -->
            <c:choose>

                <c:when test="${currentPage + 1 < totalPages}">

                    <c:url var="nextUrl" value="/students">
                        <c:param name="page" value="${currentPage + 1}"/>
                        <c:param name="size" value="${size}"/>
                        <c:param name="sortBy" value="${sortBy}"/>
                        <c:param name="direction" value="${direction}"/>
                        <c:param name="keyword" value="${keyword}"/>
                    </c:url>

                    <a href="${nextUrl}">Next</a>

                </c:when>

                <c:otherwise>
                    <span class="disabled">Next</span>
                </c:otherwise>

            </c:choose>

        </div>

    </c:if>

    <a class="home-link"
       href="${pageContext.request.contextPath}/">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>
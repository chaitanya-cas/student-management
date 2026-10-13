<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 420px;
            margin: 50px auto;
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px #cccccc;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #cccccc;
            border-radius: 5px;
        }

        .update-button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .update-button:hover {
            background-color: #218838;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Edit Student Details</h2>

    <form action="${pageContext.request.contextPath}/students/update/${student.id}"
          method="post">

        <label for="id">Student ID</label>

        <input type="text"
               id="id"
               value="<c:out value='${student.id}'/>"
               readonly>

        <label for="name">Student Name</label>

        <input type="text"
               id="name"
               name="name"
               value="<c:out value='${student.name}'/>"
               maxlength="100"
               required>

        <label for="email">Email Address</label>

        <input type="email"
               id="email"
               name="email"
               value="<c:out value='${student.email}'/>"
               maxlength="150"
               required>

        <label for="course">Course</label>

        <input type="text"
               id="course"
               name="course"
               value="<c:out value='${student.course}'/>"
               maxlength="100"
               required>

        <label for="fees">Course Fees</label>

        <input type="number"
               id="fees"
               name="fees"
               value="<c:out value='${student.fees}'/>"
               min="0"
               step="0.01"
               required>

        <button type="submit" class="update-button">
            Update Student
        </button>

    </form>

    <a class="back-link"
       href="${pageContext.request.contextPath}/students">
        Cancel and Return to Student List
    </a>

</div>

</body>
</html>
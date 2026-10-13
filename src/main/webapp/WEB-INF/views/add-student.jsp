<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Student</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 420px;
            margin: 60px auto;
            background: white;
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

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
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

    <h2>Student Registration</h2>

    <form action="${pageContext.request.contextPath}/students/save"
          method="post">

        <label for="name">Student Name</label>
        <input type="text"
               id="name"
               name="name"
               placeholder="Enter student name"
               maxlength="100"
               required>

        <label for="email">Email Address</label>
        <input type="email"
               id="email"
               name="email"
               placeholder="Enter email address"
               maxlength="150"
               required>

        <label for="course">Course</label>
        <input type="text"
               id="course"
               name="course"
               placeholder="Enter course name"
               maxlength="100"
               required>

        <label for="fees">Course Fees</label>
        <input type="number"
               id="fees"
               name="fees"
               placeholder="Enter course fees"
               min="0"
               step="0.01"
               required>

        <button type="submit">Register Student</button>

    </form>

    <a class="back-link"
       href="${pageContext.request.contextPath}/">
        Back to Home
    </a>

</div>

</body>
</html>
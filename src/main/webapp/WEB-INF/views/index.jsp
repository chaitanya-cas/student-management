<%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

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
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f4f6f9;
        color: #333;
    }

    .navbar {
        background-color: #243b55;
        color: white;
        padding: 18px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .navbar h2 {
        margin: 0;
    }

    .navbar a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
    }

    .hero {
        text-align: center;
        padding: 80px 20px;
        background-color: #e8f1ff;
    }

    .hero h1 {
        color: #243b55;
        font-size: 38px;
    }

    .hero p {
        font-size: 18px;
        color: #555;
        line-height: 1.6;
    }

    .buttons {
        margin-top: 30px;
    }

    .button {
        display: inline-block;
        padding: 13px 22px;
        margin: 8px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
    }

    .primary {
        background-color: #007bff;
        color: white;
    }

    .secondary {
        background-color: #28a745;
        color: white;
    }

    .features {
        display: flex;
        justify-content: center;
        gap: 25px;
        flex-wrap: wrap;
        padding: 40px 20px;
    }

    .card {
        width: 280px;
        background-color: white;
        padding: 25px;
        text-align: center;
        border-radius: 8px;
        box-shadow: 0 2px 10px #dddddd;
    }

    .card h3 {
        color: #243b55;
    }

    footer {
        background-color: #243b55;
        color: white;
        text-align: center;
        padding: 18px;
        margin-top: 30px;
    }

    @media (max-width: 600px) {
        .navbar {
            padding: 18px;
            flex-direction: column;
            gap: 15px;
        }

        .hero h1 {
            font-size: 28px;
        }
    }
</style>
```

</head>

<body>

```
<header class="navbar">
    <h2>Student Management</h2>

    <nav>
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/students">Students</a>
    </nav>
</header>

<main>

    <section class="hero">
        <h1>Welcome to Student Management System</h1>

        <p>
            Manage student records easily and efficiently.
            Register students, view details, update information,
            and manage student records in one place.
        </p>

        <div class="buttons">
            <a class="button primary"
               href="${pageContext.request.contextPath}/students/new">
                Register Student
            </a>

            <a class="button secondary"
               href="${pageContext.request.contextPath}/students">
                View All Students
            </a>
        </div>
    </section>

    <section class="features">

        <div class="card">
            <h3>Register Students</h3>
            <p>Add student names, email addresses, courses, and fees.</p>
        </div>

        <div class="card">
            <h3>View Student Records</h3>
            <p>View student information stored in the database.</p>
        </div>

        <div class="card">
            <h3>Manage Records</h3>
            <p>Edit student details or delete records when necessary.</p>
        </div>

    </section>

</main>

<footer>
    <p>&copy; 2026 Student Management System</p>
</footer>


</body>
</html>

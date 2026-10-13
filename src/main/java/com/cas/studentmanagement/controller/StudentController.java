package com.cas.studentmanagement.controller;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cas.studentmanagement.entity.Student;
import com.cas.studentmanagement.service.StudentService;

@Controller
public class StudentController {

    private final StudentService studentService;

    // Constructor injection
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    // Dashboard
    @GetMapping("/")
    public String home(Model model) {

        model.addAttribute(
                "totalStudents",
                studentService.getTotalStudents()
        );

        model.addAttribute(
                "totalFees",
                studentService.getTotalFees()
        );

        return "index";
    }

    // Display registration form
    @GetMapping("/students/new")
    public String showRegistrationForm(Model model) {

        model.addAttribute("student", new Student());

        return "add-student";
    }

    // Save student
    @PostMapping("/students/save")
    public String saveStudent(
            @ModelAttribute("student") Student student) {

        studentService.saveStudent(student);

        return "redirect:/students";
    }

    // Display students with pagination, sorting and search
    @GetMapping("/students")
    public String getStudents(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "id") String sortBy,
            @RequestParam(defaultValue = "asc") String direction,
            Model model) {

        // Prevent invalid pagination values
        page = Math.max(page, 0);
        size = Math.max(1, Math.min(size, 50));

        Page<Student> studentPage;

        if (keyword == null || keyword.isBlank()) {

            studentPage = studentService.getStudentsPaginated(
                    page, size, sortBy, direction
            );

        } else {

            studentPage = studentService.searchStudentsPaginated(
                    keyword, page, size, sortBy, direction
            );
        }

        // Data displayed in the JSP
        model.addAttribute("students", studentPage.getContent());
        model.addAttribute("studentPage", studentPage);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", studentPage.getTotalPages());
        model.addAttribute("totalItems", studentPage.getTotalElements());

        model.addAttribute("keyword", keyword);
        model.addAttribute("size", size);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("direction", direction);

        return "student-list";
    }

    // Edit form
    @GetMapping("/students/edit/{id}")
    public String showEditForm(
            @PathVariable Integer id,
            Model model) {

        Student student = studentService.getStudentById(id);

        model.addAttribute("student", student);

        return "edit-student";
    }

    // Update student
    @PostMapping("/students/update/{id}")
    public String updateStudent(
            @PathVariable Integer id,
            @ModelAttribute("student") Student student) {

        studentService.updateStudent(id, student);

        return "redirect:/students";
    }

    // Delete student
    @PostMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Integer id) {

        studentService.deleteStudent(id);

        return "redirect:/students";
    }

}
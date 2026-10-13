package com.cas.studentmanagement.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.cas.studentmanagement.entity.Student;
import com.cas.studentmanagement.service.StudentService;

@Controller
public class StudentController {

	private final StudentService studentService;

	public StudentController(StudentService studentService) {
		super();
		this.studentService = studentService;
	}

	// Display the home page
	@GetMapping("/")
	public String home() {

		return "index";
	}

	// Display the student registration form
	@GetMapping("/student/new")
	public String showRegistrationForm(Model model) {

		model.addAttribute("Student", new Student());

		return "add-student";
	}

	// Save Student information
	@PostMapping("/student/save")
	public String saveStudent(@ModelAttribute("student") Student student) {

		studentService.saveStudent(student);

		return "redirect:/students";
	}

	// Display all students
	@GetMapping("/students")
	public String getAllStudents(Model model) {

		List<Student> students = studentService.getAllStudents();

		model.addAttribute("students", students);

		return "student-list";
	}

	// Display the edit form
	@GetMapping("/students/edit/{id}")
	public String showEditForm(@PathVariable Integer id, Model model) {

		Student student = studentService.getStudentById(id);

		model.addAttribute("student", student);

		return "edit-student";
	}

	// Update student information
	@PostMapping("/students/update/{id}")
	public String updateStudent(@PathVariable Integer id, @ModelAttribute("student") Student student) {

		studentService.updateStudent(id, student);

		return "redirect:/students";
	}

	// Delete a student
	@PostMapping("/students/delete/{id}")
	public String deleteStudent(@PathVariable Integer id) {

		studentService.deleteStudent(id);

		return "redirect:/students";
	}

}

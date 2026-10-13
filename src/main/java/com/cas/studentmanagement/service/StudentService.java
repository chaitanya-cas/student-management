package com.cas.studentmanagement.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cas.studentmanagement.entity.Student;
import com.cas.studentmanagement.repository.StudentRepository;

@Service
@Transactional
public class StudentService {

	private final StudentRepository studentRepository;

	// Constructor injection
	public StudentService(StudentRepository studentRepository) {
		this.studentRepository = studentRepository;
	}

	// Save student
	public Student saveStudent(Student student) {
		return studentRepository.save(student);
	}

	// Get all students
	@Transactional(readOnly = true)
	public List<Student> getAllStudents() {
		return studentRepository.findAll();
	}

	// Get student by ID
	@Transactional(readOnly = true)
	public Student getStudentById(Integer id) {
		return studentRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Student not found with ID: " + id));
	}

	// Update student
	public Student updateStudent(Integer id, Student updatedStudent) {

		Student existingStudent = getStudentById(id);

		existingStudent.setName(updatedStudent.getName());
		existingStudent.setEmail(updatedStudent.getEmail());
		existingStudent.setCourse(updatedStudent.getCourse());
		existingStudent.setFees(updatedStudent.getFees());

		return studentRepository.save(existingStudent);
	}

	// Delete student
	public void deleteStudent(Integer id) {

		if (!studentRepository.existsById(id)) {
			throw new RuntimeException("Student not found with ID: " + id);
		}

		studentRepository.deleteById(id);
	}

	// Count total students
	@Transactional(readOnly = true)
	public long getTotalStudents() {
		return studentRepository.count();
	}

	// Calculate total fees
	@Transactional(readOnly = true)
	public Double getTotalFees() {
		return studentRepository.getTotalFees();
	}

	// Search students without pagination
	@Transactional(readOnly = true)
	public List<Student> searchStudents(String keyword) {
		return studentRepository.searchStudents(keyword.trim(), PageRequest.of(0, Integer.MAX_VALUE)).getContent();
	}

	// Pagination and sorting for all students
	@Transactional(readOnly = true)
	public Page<Student> getStudentsPaginated(int page, int size, String sortBy, String direction) {

		// Allow only valid entity properties for sorting
		List<String> allowedFields = List.of("id", "name", "email", "course", "fees");

		if (!allowedFields.contains(sortBy)) {
			sortBy = "id";
		}

		Sort sort = direction.equalsIgnoreCase("desc") ? Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();

		Pageable pageable = PageRequest.of(page, size, sort);

		return studentRepository.findAll(pageable);
	}

	// Search with pagination and sorting
	@Transactional(readOnly = true)
	public Page<Student> searchStudentsPaginated(String keyword, int page, int size, String sortBy, String direction) {

		List<String> allowedFields = List.of("id", "name", "email", "course", "fees");

		if (!allowedFields.contains(sortBy)) {
			sortBy = "id";
		}

		Sort sort = direction.equalsIgnoreCase("desc") ? Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();

		Pageable pageable = PageRequest.of(page, size, sort);

		return studentRepository.searchStudents(keyword.trim(), pageable);
	}
}
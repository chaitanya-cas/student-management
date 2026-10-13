package com.cas.studentmanagement.service;

import java.util.List;

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

    // Save a new student
    public Student saveStudent(Student student) {
        return studentRepository.save(student);
    }

    // Retrieve all students
    @Transactional(readOnly = true)
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // Retrieve a student by ID
    @Transactional(readOnly = true)
    public Student getStudentById(Integer id) {
        return studentRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("Student not found with ID: " + id));
    }

    // Update an existing student
    public Student updateStudent(Integer id, Student updatedStudent) {

        Student existingStudent = getStudentById(id);

        existingStudent.setName(updatedStudent.getName());
        existingStudent.setEmail(updatedStudent.getEmail());
        existingStudent.setCourse(updatedStudent.getCourse());
        existingStudent.setFees(updatedStudent.getFees());

        return studentRepository.save(existingStudent);
    }

    // Delete a student by ID
    public void deleteStudent(Integer id) {

        if (!studentRepository.existsById(id)) {
            throw new RuntimeException("Student not found with ID: " + id);
        }

        studentRepository.deleteById(id);
    }
    
    public List<Student> searchStudents(String keyword) {
        return studentRepository.searchStudents(keyword.trim());
    }
    
}
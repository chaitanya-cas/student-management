package com.cas.studentmanagement.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cas.studentmanagement.entity.Student;

public interface StudentRepository
        extends JpaRepository<Student, Integer> {

    // Search students by name or email with pagination
    @Query("""
        SELECT s FROM Student s
        WHERE LOWER(s.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(s.email) LIKE LOWER(CONCAT('%', :keyword, '%'))
        """)
    Page<Student> searchStudents(
            @Param("keyword") String keyword,
            Pageable pageable);

    // Calculate total fees
    @Query("SELECT COALESCE(SUM(s.fees), 0) FROM Student s")
    Double getTotalFees();
}
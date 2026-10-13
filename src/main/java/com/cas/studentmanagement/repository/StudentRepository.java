package com.cas.studentmanagement.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cas.studentmanagement.entity.Student;

public interface StudentRepository extends JpaRepository<Student, Integer> {

    @Query("""
        SELECT s FROM Student s
        WHERE LOWER(s.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
           OR LOWER(s.email) LIKE LOWER(CONCAT('%', :keyword, '%'))
        """)
    List<Student> searchStudents(@Param("keyword") String keyword);

    @Query("SELECT COALESCE(SUM(s.fees), 0) FROM Student s")
    Double getTotalFees();
}
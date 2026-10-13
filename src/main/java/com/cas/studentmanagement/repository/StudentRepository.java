package com.cas.studentmanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cas.studentmanagement.entity.Student;

public interface StudentRepository  extends JpaRepository<Student, Integer>{

}

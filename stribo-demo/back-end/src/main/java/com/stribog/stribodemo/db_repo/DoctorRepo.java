package com.stribog.stribodemo.db_repo;

import com.stribog.stribodemo.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
//за да можем да си модофицираме неща в JPA
public interface DoctorRepo extends JpaRepository<Doctor,Long> {
    void deleteDoctorById(long id);
  Doctor findDoctorById(long id);
}

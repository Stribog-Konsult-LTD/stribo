package com.stribog.stribodemo.db_repo;

import com.stribog.stribodemo.model.Patients;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PatientsRepo  extends JpaRepository<Patients,Long> {
  Page<Patients> findByDoctorId(Long doctorId, Pageable pageable);
  Optional<Patients> findByIdAndDoctorId(Long id, Long doctorId);
  List<Patients> findByDoctorId(Long doctorId);
  void deleteAllByDoctorId(Long doctorId);
}

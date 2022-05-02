package com.stribog.stribodemo.db_service;

import com.stribog.stribodemo.db_repo.DoctorRepo;
import com.stribog.stribodemo.db_repo.PatientsRepo;
import com.stribog.stribodemo.model.Doctor;
import com.stribog.stribodemo.model.Patients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class PatientsBDService {
  private final PatientsRepo patientsRepo;
  @Autowired
  public PatientsBDService(PatientsRepo patientsRepo) {
    this.patientsRepo = patientsRepo;
  }
  public Patients AddPatients(Patients patients) {
    return patientsRepo.save(patients);
  }
  public List<Patients> findAllPatients(Long doctorId) {
    return patientsRepo.findByDoctorId(doctorId);
  }

  public void deletePatients(Long id) {
    patientsRepo.deleteById(id);
  }
  public void deleteAllByDoctorId(Long doctorId){ patientsRepo.deleteAllByDoctorId(doctorId); }
  public Patients updatePatients(Patients employee) {
    return patientsRepo.save(employee);
  }

}

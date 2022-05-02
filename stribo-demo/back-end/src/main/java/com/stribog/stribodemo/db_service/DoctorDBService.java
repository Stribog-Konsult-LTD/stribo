package com.stribog.stribodemo.db_service;

import com.stribog.stribodemo.db_repo.DoctorRepo;
import com.stribog.stribodemo.model.Doctor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class DoctorDBService {
    private final DoctorRepo doctorRepo;

    //конструктор
    @Autowired
    public DoctorDBService(DoctorRepo doctorRepo) {
        this.doctorRepo = doctorRepo;
    }
    //добавяне на доктор
    public Doctor AddDoctor(Doctor doctor) {
        return doctorRepo.save(doctor);
    }

    public List<Doctor> findAllDoctors() {
        return doctorRepo.findAll();
    }

    public Doctor updateDoctor(Doctor doctor) {

      return doctorRepo.save(doctor);
    }

    public void deleteDoctor(Long id) {
        doctorRepo.deleteDoctorById(id);
    }
}

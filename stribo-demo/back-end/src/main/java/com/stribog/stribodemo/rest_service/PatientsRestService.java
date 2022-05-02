package com.stribog.stribodemo.rest_service;

import com.stribog.stribodemo.db_repo.DoctorRepo;
import com.stribog.stribodemo.db_repo.PatientsRepo;
import com.stribog.stribodemo.db_service.DoctorDBService;
import com.stribog.stribodemo.db_service.PatientsBDService;
import com.stribog.stribodemo.model.Doctor;
import com.stribog.stribodemo.model.Patients;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import javax.validation.Valid;
import java.util.List;

@RestController
public class PatientsRestService {
  @Autowired
  private DoctorRepo doctorRepo;

  @Autowired
  private PatientsRepo patientsRepo;

  private final PatientsBDService patientsBDService;
  public PatientsRestService(PatientsBDService patientsBDService) {
    this.patientsBDService = patientsBDService;
  }



  @GetMapping("/doctor/{doctorId}/patients")
  public List<Patients> getAllPatientsByDoctorId(@PathVariable(value = "doctorId") Long doctorId,
                                                 Pageable pageable) {
    return patientsRepo.findByDoctorId(doctorId);
  }


  //добавяне на лекар (post request)
  @PostMapping("/doctor/{doctorId}/patients/add")
  public ResponseEntity<Patients> addEmployee(@RequestBody Patients patients) {
    Patients newPatients ;
    try {
      newPatients = patientsBDService.AddPatients(patients);
    }catch (Exception e){
      MultiValueMap map=new HttpHeaders();
      map.put("DBErrorCode","Cannot insert new Patients");
      return new ResponseEntity<>(map, HttpStatus.SEE_OTHER);
    }
    return new ResponseEntity<>(newPatients, HttpStatus.CREATED);
  }
  @PostMapping("/doctor/{doctorId}/patients")
  public Patients createPatients(@PathVariable (value = "doctorId") Long doctorId,
                               @Valid @RequestBody Patients patients) {
    return doctorRepo.findById(doctorId).map(doctor -> {
//      patients.setDr(doctor);
      return patientsRepo.save(patients);
    }).orElseThrow(() -> new ResourceNotFoundException("DoctorId " + doctorId + " not found"));
  }

  @PutMapping("/doctor/{doctorId}/patients/{patientsId}")
  public Patients updatePatients(@PathVariable (value = "doctorId") Long doctorId,
                               @PathVariable (value = "patientsId") Long patientsId,
                               @Valid @RequestBody Patients patientsRequest) {
    if(!doctorRepo.existsById(doctorId)) {
      throw new ResourceNotFoundException("DoctorId " + doctorId + " not found");
    }

    return patientsRepo.findById(patientsId).map(patients -> {
      patients.setName(patientsRequest.getName());
      patients.setEgn(patientsRequest.getEgn());
      patients.setEmail(patientsRequest.getEmail());

      return patientsRepo.save(patients);
    }).orElseThrow(() -> new ResourceNotFoundException("PatientsID " + patientsId + "not found"));
  }

  @DeleteMapping("/doctor/{doctorId}/patients/{patientsId}")
  public ResponseEntity<?> deletePatients(@PathVariable (value = "doctorId") Long doctorId,
                                         @PathVariable (value = "patientsId") Long patientsId) {
    return patientsRepo.findByIdAndDoctorId(patientsId, doctorId).map(patients -> {
      patientsRepo.delete(patients);
      return ResponseEntity.ok().build();
    }).orElseThrow(() -> new ResourceNotFoundException("PatientsID not found with id " + patientsId + " and doctorId " + doctorId));
  }
}

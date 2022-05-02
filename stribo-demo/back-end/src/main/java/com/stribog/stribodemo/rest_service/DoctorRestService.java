package com.stribog.stribodemo.rest_service;

import com.stribog.stribodemo.db_repo.DoctorRepo;
import com.stribog.stribodemo.db_service.DoctorDBService;
import com.stribog.stribodemo.model.Doctor;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.validation.Valid;

@RestController
@RequestMapping("/doctor")
public class DoctorRestService {
  private final DoctorDBService doctorDBService;

  @Autowired
  private DoctorRepo doctorRepo;

    //конструктор
    public DoctorRestService(DoctorDBService doctorDBService) {
        this.doctorDBService = doctorDBService;
    }

    //получаваме JSON със всички лекари (get request)



    @GetMapping("/all")
    public ResponseEntity<List<Doctor>> getAllDoctors() {
        List<Doctor> doctors = doctorDBService.findAllDoctors();
        return new ResponseEntity<>(doctors, HttpStatus.OK);
    }


    //добавяне на лекар (post request)
    @PostMapping("/add")
    public ResponseEntity<Doctor> addDoctor(@RequestBody Doctor doctor) {
        Doctor newDoctor ;
        try {
          newDoctor = doctorDBService.AddDoctor(doctor);
        }catch (Exception e){
          MultiValueMap map=new HttpHeaders();
          map.put("DBErrorCode","Cannot insert new Doctor");
          return new ResponseEntity<>(map,HttpStatus.SEE_OTHER);
        }
        return new ResponseEntity<>(newDoctor, HttpStatus.CREATED);
    }

    //ъпдейт на лекар (put request)
    @PutMapping("/update")
    public ResponseEntity<Doctor> updateDoctor(@RequestBody Doctor doctor) {
      Doctor oldDoctor=doctorRepo.findDoctorById(doctor.getId());
      doctor.setChildren(oldDoctor.getChildren());
        Doctor updateDoctor = doctorDBService.updateDoctor(doctor);
        return new ResponseEntity<>(updateDoctor, HttpStatus.OK);
    }

    //изтриване на лекар (delete request)
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteDoctor(@PathVariable("id") Long id) {
        doctorDBService.deleteDoctor(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

  @GetMapping("/doctors")
  public Page<Doctor> getAllDoctors(Pageable pageable) {
    return doctorRepo.findAll(pageable);
  }

  @PostMapping("/doctor")
  public Doctor createDoctor(@Valid @RequestBody Doctor doctor) {
    return doctorRepo.save(doctor);
  }

/*
  @PutMapping("/posts/{doctorId}")
  public Doctor updatePost(@PathVariable Long doctorId, @Valid @RequestBody Doctor postRequest) {
    return doctorRepo.findById(doctorId).map(doctor -> {
      doctor.setName(postRequest.getName());
      doctor.setUinCode(postRequest.getUinCode());
      doctor.setEmail(postRequest.getEmail());
      doctor.setPhone(postRequest.getPhone());
      doctor.setJobTitle(postRequest.getJobTitle());
      doctor.setWorkPlace(postRequest.getWorkPlace());
      doctor.setImageUrl(postRequest.getImageUrl());

      return doctorRepo.save(doctor);
    }).orElseThrow(() -> new ResourceNotFoundException("PostId " + doctorId + " not found"));
  }
*/
  @DeleteMapping("/posts/{doctorId}")
  public ResponseEntity<?> deletePost(@PathVariable Long doctorId) {
    return doctorRepo.findById(doctorId).map(doctor -> {
      doctorRepo.delete(doctor);
      return ResponseEntity.ok().build();
    }).orElseThrow(() -> new ResourceNotFoundException("PostId " + doctorId + " not found"));
  }
}

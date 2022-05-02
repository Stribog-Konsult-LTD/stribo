package com.stribog.stribodemo.model;

import com.fasterxml.jackson.annotation.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "patients")
public class Patients implements Serializable {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id", nullable = false)
  private Long id;
  private String name;
  //uin кода на всеки лекар - трябва да е уникален, и винаги да присъства !
  @Column(unique = true, nullable = false)
  private String egn;
  private String email;
  @Column(name = "doctor_id")
  private Long doctorId;

  public Patients() {
  }

  public Patients(String name, String egn, String email, Long doctorId) {
    this.name = name;
    this.egn = egn;
    this.email = email;
    this.doctorId = doctorId;
  }

  public Long getDoctorId() {
    return doctorId;
  }

  public void setDoctorId(Long doctorId) {
    this.doctorId = doctorId;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getEgn() {
    return egn;
  }

  public void setEgn(String egn) {
    this.egn = egn;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }


}

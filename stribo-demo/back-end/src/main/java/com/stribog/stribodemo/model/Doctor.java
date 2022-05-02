package com.stribog.stribodemo.model;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.cache.spi.support.AbstractReadWriteAccess;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
//Класа за данните за Доктор
//Ще се сериализира заради JSON'a при  РЕСТ

//JPA entity - за магията :-)
@Entity
@Table(name = "doctor")
public class Doctor implements Serializable {
    //JPA настройките за id полето на таблицата - име на полето, авто генерирано, не може да е празно и тн...
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;
    private String name;
    //uin кода на всеки лекар - трябва да е уникален, и винаги да присъства !
    @Column(unique = true,nullable = false)
    private String uinCode;
    private String email;
    private String phone;
    private String jobTitle;
    private String workPlace;

    private String imageUrl;



    //конструктори
    public Doctor() {}

    public Doctor(Long id, String name, String uinCode, String email, String phone, String jobTitle, String workPlace, String imageUrl) {
        this.id = id;
        this.name = name;
        this.uinCode = uinCode;
        this.email = email;
        this.phone = phone;
        this.jobTitle = jobTitle;
        this.workPlace = workPlace;
        this.imageUrl = imageUrl;
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

    public String getUinCode() {
        return uinCode;
    }

    public void setUinCode(String uinCode) {
        this.uinCode = uinCode;
    }

    public String getEmail() {
        return email;
    }


    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getWorkPlace() {
        return workPlace;
    }

    public void setWorkPlace(String workPlace) {
        this.workPlace = workPlace;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }



  @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE,
    CascadeType.REFRESH},orphanRemoval = true)
  @JoinColumn(name = "doctor_id")
  private List<com.stribog.stribodemo.model.Patients> items;
  public List getChildren(){
    return items;
  }
  public void setChildren(List list){
    if(items!=null)
      items.clear();
    items=new ArrayList<>();
    if(list!=null)
      items.addAll(list);
  }

}

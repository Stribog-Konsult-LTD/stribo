import {Component, Input, OnInit} from '@angular/core';
import {PatientResp} from "../patient/patient";
import {PatientRestService} from "../patient/patient.rest.service";
import {HttpErrorResponse} from "@angular/common/http";

@Component({
  selector: 'app-patients',
  templateUrl: './patients.component.html',
  styleUrls: ['./patients.component.css']
})
export class PatientsComponent implements OnInit {

  backEndStatus="unknown";
  public patients:PatientResp[]=[]
  public patientsCount:number=0;
  @Input() doctorId:number=-1;

  constructor(private patientRestService: PatientRestService) { }

  public onPatientDeleted(value:string){
    alert(value);
    this.getDoctorsPatient(this.doctorId);
  }

  public getDoctorsPatient(doctorId:number): void {

    //ще се събскрибнем към рест сървиза:
    const getDoctorsPatientObserver = {
      next: (response: PatientResp[]) => {
        //this.jData[doctorId]=response[doctorId];
        this.patients = response;
        console.log("Patients: ", this.patients);
        console.log("doctorId: ", doctorId)
      },
      error: (error: HttpErrorResponse) => {
        this.backEndStatus = "disconnected";
        alert(error.message);
      },
      complete: () => console.log('Observer got a complete notification'),
    };
    this.patientRestService.getPatients(doctorId).subscribe(getDoctorsPatientObserver);

  }


  ngOnInit(): void {
    console.log("PATIENT::doctorId: ", this.doctorId)
    this.getDoctorsPatient(this.doctorId);
  }

}

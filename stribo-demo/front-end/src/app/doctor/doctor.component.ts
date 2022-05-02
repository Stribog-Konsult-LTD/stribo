import {Component, EventEmitter, Input, OnInit, Output, TemplateRef, ViewChild} from '@angular/core';
import {Doctor} from "./doctor";
import {HttpErrorResponse} from "@angular/common/http";
import {DoctorRestService} from "./doctor.rest.service";
import {PatientRestService} from "../patient/patient.rest.service";
import {NgForm} from "@angular/forms";
import {IDynamicDialogConfig} from "../dialog.config";
import {ModalDialogComponent} from "../modal-dialog/modal-dialog.component";
import {MAT_DIALOG_DATA, MatDialog} from "@angular/material/dialog";
import {Patient, PatientResp} from "../patient/patient";
import {FormControl, Validators} from '@angular/forms';

@Component({
  selector: 'app-doctor',
  templateUrl: './doctor.component.html',
  styleUrls: ['./doctor.component.css']
})
export class DoctorComponent implements OnInit {

  public avatars:any[] = [];
  public selection: string="https://i.pravatar.cc/150?img=68";

  backEndStatus="unknown";
  public doctors:Doctor[] = [];
  public currentDoctor: Doctor | undefined;
  public doctorsCount:number=0;

  @Output() statusChanged = new EventEmitter<string>();

  emitStatusChanged(value: string){
    this.statusChanged.emit(value);
  }

  constructor(private doctorRestService: DoctorRestService, private patientRestService: PatientRestService,public dialog: MatDialog) {
    for (let i = 1; i <= 70; i++) {
      let obj={ value: `https://i.pravatar.cc/150?img=${i}`, viewValue:  `https://i.pravatar.cc/150?img=${i}`, img: `https://i.pravatar.cc/150?img=${i}` };
      this.avatars.push(obj);
    }

  }

  public getDoctors(): void {
    this.backEndStatus = "connecting ...";

    //ще се събскрибнем към рест сървиза:
    const getDoctorsObserver = {
      next: (response: Doctor[]) => {
        //имаме валиден отговор от бекенда

        this.backEndStatus = "connected";
        this.emitStatusChanged(this.backEndStatus );
        this.doctors = response;
        this.doctorsCount=this.doctors.length;
        console.log("All doctors:", this.doctors)
      },
      error: (error: HttpErrorResponse) => {
        this.backEndStatus = "disconnected";
        this.emitStatusChanged(this.backEndStatus );
        let errorMessage=`Back-end respond with:\n "${error.message}" \n Probably there are server issues ! Check your backend!`
        alert(errorMessage);
      },
      complete: () =>{
        console.log('Observer got a complete notification');
      }
    };

    this.doctorRestService.getDoctors().subscribe(getDoctorsObserver);
  }

  public testAdd(message:string){
    alert(message);
  }

  @ViewChild('addDoctorDialogTemplate') addDoctorDialogTemplate: TemplateRef<any> | undefined;
  public addDoctor() {
    let Data: any = {
      dialog: <IDynamicDialogConfig>{
        title: 'Add Doctor',
        dialogContent: this.addDoctorDialogTemplate,
        acceptButtonTitle: 'Add!',
        declineButtonTitle: 'Cancel !',
        formName: 'addForm'
      }
    }
    const dialogRef = this.dialog.open(ModalDialogComponent, {
      width: '250px',
      data: Data
    });
  }
  public onAddDoctor(addForm: NgForm): void {
    console.log("onAddDoctor:",addForm.value);
    let isValid = this._formCheck(addForm);
    if (isValid===false)return;
    const addDoctorObserver={
      next: (response: Doctor) => {
        console.log("onAddDoctor:",response);
        this.getDoctors();
        addForm.reset();
      },
      error: (error: HttpErrorResponse) => {
        this.backEndStatus = "disconnected";
        alert(error.message);
      },
      complete: () => console.log('addDoctorObserver got a complete notification'),
    }
    this.doctorRestService.addDoctor(addForm.value).subscribe(addDoctorObserver);
  }

  @ViewChild('editDoctorDialogTemplate') editDoctorDialogTemplate: TemplateRef<any> | undefined;
  editDoctor(doctor: Doctor) {
    this.currentDoctor = doctor;
    let Data: any = {
      dialog: <IDynamicDialogConfig>{
        title: 'Edit ' + doctor.name,
        dialogContent: this.editDoctorDialogTemplate,
        acceptButtonTitle: 'Save Changes!',
        declineButtonTitle: 'Cancel !',
        formName: 'editForm'
      },
      aDoctor: doctor
    }
    console.log("editDoctorDialogTemplate::Data:", Data)
    const dialogRef = this.dialog.open(ModalDialogComponent, {
        width: '350px',
        data: Data
      }
    );
  }
  public onUpdateDoctor(doctor: Doctor): void {
    console.log("onUpdateDoctor::форм вали:",doctor);
    this.doctorRestService.updateDoctor(doctor).subscribe(
      (response: Doctor) => {
        console.log("updateDoctor:",response);
        this.getDoctors();
      },
      (error: HttpErrorResponse) => {
        alert(error.message);
      }
    );
  }

  @ViewChild('removeDoctorDialogTemplate') removeDoctorDialogTemplate: TemplateRef<any> | undefined;
  public removeDoctor(doctor:Doctor) {
    this.currentDoctor=doctor;
    let Data: any = {
      dialog: <IDynamicDialogConfig>{
        title: `Remove Doctor "${doctor.name}" ?`,
        dialogContent: this.removeDoctorDialogTemplate,
        acceptButtonTitle: 'Remove!',
        declineButtonTitle: 'Cancel !',
        formName: 'deleteForm'
      },
      aDoctor: doctor
    }
    console.log("removeDoctor::Data:",Data);
    const dialogRef = this.dialog.open(ModalDialogComponent, {
      width: '250px',
      data:Data
    });
  }


  public onDeleteDoctor(doctor:Doctor): void {
    console.log("onDeleteDoctor::doctor:",doctor);

    const deleteDoctorObserver={
      next: (response: void) => {
        console.log("onDeleteDoctor::response:",response);
        this.getDoctors();
      },
      error: (error: HttpErrorResponse) => {
        this.backEndStatus = "disconnected";
        alert(error.message);
      },
      complete: () => console.log('deleteDoctorObserver got a complete notification'),
    }

    this.doctorRestService.deleteDoctor(doctor.id).subscribe(
      (response: void) => {
        console.log("onDeleteDoctor::response:",response);
        this.getDoctors();
      },
      (error: HttpErrorResponse) => {
        alert(error.message);
      }
    );
  }

  @ViewChild('addPatientDialogTemplate') addPatientDialogTemplate: TemplateRef<any> | undefined;

  public addPatient(doctor:Doctor) {
    this.currentDoctor=doctor;
    let Data: any = {
      dialog: <IDynamicDialogConfig>{
        title: `Assign patient to Doctor "${doctor.name}"`,
        dialogContent: this.addPatientDialogTemplate,
        acceptButtonTitle: 'Add!',
        declineButtonTitle: 'Cancel !',
        formName: 'addPatientForm'
      },
      aDoctor: doctor
    }
    const dialogRef = this.dialog.open(ModalDialogComponent, {
      width: '250px',
      data: Data
    });
  }

  private _formCheck(aForm:NgForm){
    console.log("Form is valid:",aForm.valid);
    return aForm.valid;
  }

  onAddPatient(addPatientForm: NgForm):void {

    console.log("onAddPatient::addPatientForm.valid:",addPatientForm.valid);
    let isValid = this._formCheck(addPatientForm);
    if (isValid===false)return;

    let doctorId:number = addPatientForm.value.doctorId;
    const addPatientObserver={
      next: (response:Patient) => {
        console.log("onAddPatient:",response);
        this.getDoctors();
        addPatientForm.reset();
      },
      error: (error: HttpErrorResponse) => {
        addPatientForm.reset();
        this.backEndStatus = "disconnected";
        alert(error.message);
      },
      complete: () => console.log('addDoctorObserver got a complete notification'),
    }
    this.patientRestService.addPatient(doctorId,addPatientForm.value).subscribe(addPatientObserver);
  }

  ngOnInit(): void {
    this.getDoctors();
    console.log('DoctorComponent::ngOnInit::this.doctorsCount:',this.doctorsCount);
    console.log('DoctorComponent::ngOnInit::this.avatars:',this.avatars);
  }
}

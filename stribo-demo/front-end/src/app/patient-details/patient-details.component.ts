import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {Patient, PatientResp} from "../patient/patient";
import {HttpErrorResponse} from "@angular/common/http";
import {PatientRestService} from "../patient/patient.rest.service";

@Component({
  selector: 'app-patient-details',
  templateUrl: './patient-details.component.html',
  styleUrls: ['./patient-details.component.css']
})
export class PatientDetailsComponent implements OnInit {

  @Input() dId:number=-1;
  @Input() currentPatient:PatientResp|undefined;

  @Output() patientDeleted = new EventEmitter<string>();

  emitPatientRemoved(value: string){
    this.patientDeleted.emit(value);
  }

  constructor(private patientRestService: PatientRestService) { }

  public removePatient():void{
    console.log("removePatient::dovtor ID:",this.dId);
    if(confirm("Are you sure to delete "+this.currentPatient?.name)) {
      console.log("start deleting");
      console.log("onDeletePatient::patient:",this.currentPatient);
      const deletePatientObserver={
        next: (response: void) => {
          this.emitPatientRemoved(`patient eith ${this.dId} was deleted !`)
          console.log("onDeletePatient::response:",response);
        },
        error: (error: HttpErrorResponse) => {
          alert(error.message);
        },
        complete: () => console.log('deletePatientObserver got a complete notification'),
      }

      this.patientRestService.deletePatient(this.dId,this.currentPatient?.id).subscribe(deletePatientObserver)

    }
  }

  ngOnInit(): void {
  }

}

import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MatToolbarModule} from "@angular/material/toolbar";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatGridListModule} from "@angular/material/grid-list";
import {MatTableModule} from "@angular/material/table";
import {MatIconModule} from "@angular/material/icon";
import {MAT_DIALOG_DATA, MatDialogModule, MatDialogRef} from "@angular/material/dialog";
import {MatCardModule} from "@angular/material/card";
import {MatInputModule} from "@angular/material/input";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {MatExpansionModule} from "@angular/material/expansion";
import {HttpClientModule} from "@angular/common/http";
import {MatButtonModule} from "@angular/material/button";
import { DoctorComponent } from './doctor/doctor.component';
import { PatientsComponent } from './patients/patients.component';
import { PatientDetailsComponent } from './patient-details/patient-details.component';
import {ModalDialogComponent} from "./modal-dialog/modal-dialog.component";
import {MatSelectModule} from "@angular/material/select";

@NgModule({
  declarations: [
    ModalDialogComponent,
    AppComponent,
    DoctorComponent,
    PatientsComponent,
    PatientDetailsComponent
  ],
    imports: [
        BrowserModule,
        AppRoutingModule,
        //трябва ни
        // заради рест заявките
        HttpClientModule,
        //заради формите на NG
        FormsModule,
        MatDialogModule,
        MatButtonModule,
        BrowserAnimationsModule,
        MatCardModule,
        MatInputModule,
        MatFormFieldModule,
        MatGridListModule,
        MatTableModule,
        MatExpansionModule,
        MatToolbarModule,
        MatIconModule,
        ReactiveFormsModule,
        MatSelectModule
    ],
  providers: [DoctorComponent,ModalDialogComponent,
    {
      provide: MAT_DIALOG_DATA,
      useValue: {} // Add any data you wish to test if it is passed/used correctly
    },
    {
      provide: MatDialogRef,
      useValue: {}
    }],
  bootstrap: [AppComponent]
})
export class AppModule { }

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import {Doctor} from "./doctor";
import {environment} from "../../environments/environment";

//класа за РЕСТ заявките към бекенда (сървъра)
@Injectable({providedIn: 'root'})
export class DoctorRestService{
  //адреса на бекенда
  public ServerUrl = environment.apiBaseUrl;

  constructor(private http: HttpClient){}

  public getDoctors(): Observable<Doctor[]> {
    return this.http.get<Doctor[]>(`${this.ServerUrl}/doctor/all`);
  }

  public addDoctor(doctor: Doctor): Observable<Doctor> {
    return this.http.post<Doctor>(`${this.ServerUrl}/doctor/add`, doctor);
  }

  public updateDoctor(doctor: Doctor): Observable<Doctor> {
    return this.http.put<Doctor>(`${this.ServerUrl}/doctor/update`, doctor);
  }

  public deleteDoctor(doctorId: number): Observable<void> {
    return this.http.delete<void>(`${this.ServerUrl}/doctor/delete/${doctorId}`);
  }
}

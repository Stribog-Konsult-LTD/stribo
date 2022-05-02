//класа за РЕСТ заявките към бекенда (сървъра)
import {Injectable} from "@angular/core";
import {environment} from "../../environments/environment";
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {Patient, PatientResp} from "./patient";

@Injectable({providedIn: 'root'})
export class PatientRestService{
  //адреса на бекенда
  private ServerUrl = environment.apiBaseUrl;

  constructor(private http: HttpClient){}

  public getPatients(doctorId:number): Observable<PatientResp[]> {
    return this.http.get<PatientResp[]>(`${this.ServerUrl}/doctor/${doctorId}/patients`);
  }

  public addPatient(doctorId:number,Patient: Patient): Observable<Patient> {
    return this.http.post<Patient>(`${this.ServerUrl}/doctor/${doctorId}/patients`, Patient);
  }

  public updatePatient(Patient: Patient): Observable<Patient> {
    return this.http.put<Patient>(`${this.ServerUrl}/Patient/update`, Patient);
  }
///doctor/{doctorId}/patients/{patientsId}
  public deletePatient(doctorId:number,PatientId: number | undefined): Observable<void> {
    return this.http.delete<void>(`${this.ServerUrl}/doctor/${doctorId}/patients/${PatientId}`);
  }
}

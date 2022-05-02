import {Doctor} from "../doctor/doctor";

export interface Patient{
  id:number;
  name:string;
  egn:string;
  email:string;
  doctorId:number;
}

export interface PatientResp{
  id:number;
  name:string;
  egn:string;
  email:string;
  doctorId:number;
  dr:Doctor
}

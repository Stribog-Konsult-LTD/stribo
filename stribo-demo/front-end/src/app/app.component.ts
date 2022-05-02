import {Component, isDevMode, OnInit} from '@angular/core';
import {environment} from "../environments/environment";
import {Doctor} from "./doctor/doctor";
import {DoctorComponent} from "./doctor/doctor.component";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'front-end';
  public sURL = environment.apiBaseUrl
  public backEndStatus: string = "connecting";
  constructor() {  }

  public onBackendStatusChanged(value:string){
    this.backEndStatus=value;
  }

  ngOnInit(): void {
    if (isDevMode()) {
      console.log('Development!');
    } else {
      console.log('Production!');
    }
  }
}

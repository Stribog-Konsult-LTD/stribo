import {Component, Inject, OnInit, TemplateRef, VERSION, ViewChild} from '@angular/core';
import {MAT_DIALOG_DATA} from "@angular/material/dialog";
import {IDynamicDialogConfig} from "../dialog.config";


@Component({
  selector: 'app-modal-dialog',
  templateUrl: './modal-dialog.component.html',
  styleUrls: ['./modal-dialog.component.css']
})

export class ModalDialogComponent implements OnInit {
  constructor(
    @Inject(MAT_DIALOG_DATA) public data: any ) {
  }

  aName = 'Angular ' + VERSION.major;
  count: number = 20;

  ngOnInit(): void {
    console.log("ts:::ngOnInit::name:", this.aName);
  }

}

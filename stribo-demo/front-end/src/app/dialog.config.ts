import {TemplateRef} from "@angular/core";

export interface IDynamicDialogConfig {
  title?: string;
  acceptButtonTitle?: string;
  declineButtonTitle?: string;
  dialogContent: TemplateRef<any>;
  formName:string;
}

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { AngularDualListBoxModule } from 'angular-dual-listbox';


import { DualListboxComponent } from './duallistbox.component';

@NgModule({
	imports: [
		CommonModule,
		FormsModule
	],
	declarations: [
		DualListboxComponent
	],
	exports: [
		DualListboxComponent
	]
})
export class DualListboxModule { }
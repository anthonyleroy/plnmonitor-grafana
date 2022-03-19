import { Component, OnInit, ViewChild } from '@angular/core';
import { AvailableBox } from './availableBox';
import { AvailableboxesService } from './availableboxes.service';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import { MatTable } from '@angular/material/table';
import { MatDialog } from '@angular/material/dialog';
import { DialogBoxComponent } from './dialog-box/dialog-box.component';
import { MatTableDataSource } from '@angular/material/table'; 



@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css', "./app.component.scss"]
})


export class AppComponent implements OnInit{
  title = 'lockss-dashboard-config';


  constructor(private availableboxesService: AvailableboxesService, private _formBuilder: FormBuilder, public dialog: MatDialog) {
  }

	message;
  configUrl;
	//source = AppComponent.tube;
  allBoxes = new Array<string> ();
  sourceBoxes = new Array<string>();
  
  availableBoxes = new Array<AvailableBox>();

  targetBoxes = new Array<string> ();

  allPublishers = new Array<string> ("Wiley","Springer", "ULB");
  sourcePublishers = new Array<string> ("Wiley","Springer", "ULB");
  targetPublishers = new Array<string> ("Wiley");

  public dataSource = new MatTableDataSource<AvailableBox>();

  isLinear = true;
  firstFormGroup: FormGroup;
  secondFormGroup: FormGroup;
  thirdFormGroup: FormGroup;
  fourthFormGroup: FormGroup;
  fifthFormGroup: FormGroup;
  
  displayedColumns: string[] = ['id', 'ipAddress', 'name', 'userName', 'password', 'longitude', 'latitude', 'country', 'action'];
  
  regUrl =  /^[A-Za-z][A-Za-z\d.+-]*:\/*(?:\w+(?::\w+)?@)?[^\s/]+(?::\d+)?(?:\/[\w#!:.?+=&%@\-/]*)?$/

  @ViewChild(MatTable,{static:true}) table: MatTable<any>;


  generateDashboards(){
    console.log(this.firstFormGroup.value);
    console.log(this.secondFormGroup.value);
  }

 
  ngOnInit() {

    this.firstFormGroup = this._formBuilder.group({
      url: ['', [Validators.required, Validators.pattern(this.regUrl)]]

      
      });
      
    this.secondFormGroup = this._formBuilder.group({
      });

    this.thirdFormGroup = this._formBuilder.group({
      });

    this.fourthFormGroup = this._formBuilder.group({
      });

    this.fifthFormGroup = this._formBuilder.group({
      });

    

  }

  get m(){
    return this.firstFormGroup.controls;
  }
  clickEvent(){
    this.message="Current selection: \n"
    this.targetBoxes.forEach(element => {
      this.message = this.message + element;
    });
    return this.message;
  }

  submitUrl(){
    // clear previous boxes

    this.sourceBoxes = new Array<string>();
  
    this.availableBoxes = new Array<AvailableBox>();
  
    this.targetBoxes = new Array<string> ();

    // call to get available boxes API
    this.availableboxesService.getAvailableBoxes(this.configUrl).subscribe(data => {
      //console.log(data);
      data.data.forEach(attrib => 
        this.availableBoxes.push(new AvailableBox(attrib.id, attrib.box.ipAddress, parseFloat(attrib.longitude), parseFloat(attrib.latitude), attrib.name, attrib.country, attrib.userName, attrib.password ))
      );
      console.log(this.availableBoxes);
      this.dataSource = new MatTableDataSource(this.availableBoxes);
      //this.availableBoxes = data.data;
      //console.log(this.availableBoxes);
      this.availableBoxes.forEach( value => 
        this.sourceBoxes.push(value.ipAddress + "(" + value.name + ")")
      );
      this.dataSource.data = this.availableBoxes;
      //this.allBoxes=this.sourceBoxes;
      //console.log(this.sourceBoxes)
    });
  }

	compareBoxes(a:any, b:any) {
		const arrBoxes = this.allBoxes;
		return arrBoxes.indexOf(a._id) - arrBoxes.indexOf(b._id);
	}

  comparePublishers(a:any, b:any) {
    const arrPublishers = this.allPublishers;
		return arrPublishers.indexOf(a._id) - arrPublishers.indexOf(b._id);
	}


	showMessageBoxes(e:any) {
		this.message = { selectChange: e };
		//this.message = { "Value of source: ": this.sourceBoxes,"Value of target: ": this.targetBoxes  };
  }

	showMessagePublishers(e:any) {
		this.message = { selectChange: e };
		//this.message = { "Value of source: ": this.sourceBoxes,"Value of target: ": this.targetBoxes  };
  }
  
  openDialog(action,obj) {
    obj.action = action;
    const dialogRef = this.dialog.open(DialogBoxComponent, {
      width: '500px',
      data:obj
    });

    dialogRef.afterClosed().subscribe(result => {
      if(result.event == 'Add'){
        //this.addRowData(result.data);
      }else if(result.event == 'Update'){
        this.updateRowData(result.data);
      }else if(result.event == 'Delete'){
        //this.deleteRowData(result.data);
      }
    });
  }

  /*addRowData(row_obj){
    var d = new Date();
    this.dataSource.push({
      id:d.getTime(),
      ipAddress:row_obj.ipAddress
    });
    this.table.renderRows();
    
  }*/
  updateRowData(row_obj){
    this.dataSource.data = this.dataSource.data.filter((value,key)=>{
      if(value.id == row_obj.id){
        value.ipAddress = row_obj.ipAddress;
        value.name= row_obj.name;
        value.userName=row_obj.userName;
        value.password=row_obj.password;
        value.country=row_obj.country;
        value.latitude=row_obj.latitude;
        value.longitude=row_obj.longitude;
        value.country=row_obj.country;
      }
      return true;
    });
  }
  // deleteRowData(row_obj){
  //   this.dataSource = this.dataSource.filter((value,key)=>{
  //     return value.id != row_obj.id;
  //   });
  // }
}


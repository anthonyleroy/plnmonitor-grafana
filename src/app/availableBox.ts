import { logging } from "protractor";

export class AvailableBox {
    public id: number;
    public name : string;
    public ipAddress: string;
    public longitude: number;
    public latitude: number;
    public country: string;
    public userName: string;
    public password: string;

    constructor(id:number, ipAddress:string, longitude?: number, latitude?: number, name?: string, country?:string, userName?:string, password?:string ) {
      this.id = id;
      this.ipAddress = ipAddress;
      this.longitude = longitude;
      this.latitude = latitude;
      this.name=name;
      this.country=country;
      this.userName=userName;
      this.password=password;
    }

  }
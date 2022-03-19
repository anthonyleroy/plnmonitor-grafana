export class DashboardApiResponse {
    status: string;
    data: any;

    constructor(status: string, data: any) {
        this.status = status;
        this.data = data;
      }

    getData() {
        return this.data;
    }

  }
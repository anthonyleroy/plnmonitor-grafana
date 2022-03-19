import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { MessageService } from './message.service';
import { DashboardApiResponse } from './dashboardapiresponse';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AvailableboxesService {
   private availableBoxesUrl = 'http://127.0.0.1:8080/api/lockssdashboard/boxes?configUrl=';  // URL to web api

  httpOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'application/json' })
  };

  constructor(
    private http: HttpClient,
    private messageService: MessageService
  ) { }


  public getAvailableBoxes(configUrl): Observable<any>  {
    const url = `${this.availableBoxesUrl}`+configUrl;
    return this.http.get(url)
      .pipe(
        catchError(this.handleError('getAvailableBoxes', []))
      );
  }
  /* 
 public getAvailableBoxes(): Observable<AvailableBox[]> {
    return this.http.get<AvailableBox[]>(this.availableBoxesUrl)
      .pipe(
        catchError(this.handleError<AvailableBox[]>('getAvailableBoxes', []))
      );
  }
 */
  /** GET hero by id. Will 404 if id not found */
getAvailableBox(id: number): Observable<DashboardApiResponse> {
  const url = `${this.availableBoxesUrl}/${id}`;
  return this.http.get<DashboardApiResponse>(url).pipe(
    tap(_ => this.log(`fetched AvailableBox id=${id}`)),
    catchError(this.handleError<DashboardApiResponse>(`getAvailableBox id=${id}`))
  );
}
 
  /** Log a HeroService message with the MessageService */
private log(message: string) {
  this.messageService.add(`HeroService: ${message}`);
}

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
  
      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead
  
      // TODO: better job of transforming error for user consumption
      this.log(`${operation} failed: ${error.message}`);
  
      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }
}

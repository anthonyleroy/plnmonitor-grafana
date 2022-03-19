import { TestBed } from '@angular/core/testing';

import { AvailableboxesService } from './availableboxes.service';

describe('AvailableboxesService', () => {
  let service: AvailableboxesService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AvailableboxesService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

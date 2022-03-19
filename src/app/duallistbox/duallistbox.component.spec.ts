import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DualListboxComponent } from './duallistbox.component';

describe('DuallistboxComponent', () => {
  let component: DualListboxComponent;
  let fixture: ComponentFixture<DualListboxComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DualListboxComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DualListboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

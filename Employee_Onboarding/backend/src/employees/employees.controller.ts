import { Controller, Get, Post, Param, Body } from '@nestjs/common';
import { EmployeesService } from './employees.service';

@Controller('employees')
export class EmployeesController {
  constructor(private service: EmployeesService) {}

  // CREATE EMPLOYEE
  @Post()
  create(@Body() body: any) {
    return this.service.create(body);
  }

  // GET ALL
  @Get()
  getAll() {
    return this.service.findAll();
  }

  // MANAGER APPROVE
  @Post(':id/manager-approve')
  manager(@Param('id') id: string) {
    return this.service.updateStatus(Number(id), 'MANAGER_APPROVED');
  }

  // FINANCE APPROVE
  @Post(':id/finance-approve')
  finance(@Param('id') id: string) {
    return this.service.updateStatus(Number(id), 'FINANCE_APPROVED');
  }

  // IT DONE → COMPLETED
  @Post(':id/it-done')
  it(@Param('id') id: string) {
    return this.service.updateStatus(Number(id), 'COMPLETED');
  }

  // REJECT
  @Post(':id/reject')
  reject(@Param('id') id: string) {
    return this.service.updateStatus(Number(id), 'NEEDS_REWORK');
  }

  //RESUBMIT
  @Post(':id/resubmit')
  resubmit(@Param('id') id: string) {
    return this.service.updateStatus(Number(id), 'HR_SUBMITTED');
  }
}

import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

@Injectable()
export class EmployeesService {
  constructor(private prisma: PrismaService) {}

  create(data: any) {
    return this.prisma.employee.create({ data });
  }

  findAll() {
    return this.prisma.employee.findMany();
  }

  updateStatus(id: number, status: string) {
    return this.prisma.employee.update({
      where: { id },
      data: { status },
    });
  }
}

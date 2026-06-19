import { Module } from '@nestjs/common';
import { EmployeesModule } from './employees/employees.module';
import { PrismaService } from './prisma.service';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot(), // ✅ IMPORTANT
    EmployeesModule
  ],
  providers: [PrismaService],
})
export class AppModule {}
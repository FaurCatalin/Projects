import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import 'dotenv/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors(); // 💥 fără asta frontend NU merge

  await app.listen(3001);
}
bootstrap();
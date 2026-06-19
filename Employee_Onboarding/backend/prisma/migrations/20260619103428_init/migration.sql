-- CreateTable
CREATE TABLE "Employee" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "hardware" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'HR_SUBMITTED',

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

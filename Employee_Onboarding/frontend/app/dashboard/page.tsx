"use client";

import { useEffect, useState } from "react";
import Table from "../../components/Table";

type Employee = {
  id: number;
  name: string;
  role: string;
  status: string;
  hardware: string;
};

export default function Dashboard() {
  const [employees, setEmployees] = useState<Employee[]>([]);

  const fetchData = () => {
    fetch("http://localhost:3001/employees")
      .then(res => res.json())
      .then(setEmployees)
      .catch(() => {
        setEmployees([
          {
            id: 1,
            name: "Test User",
            role: "Developer",
            status: "HR_SUBMITTED",
            hardware: "PREMIUM",
          },
        ]);
      });
  };

  useEffect(() => {
    fetchData();
  }, []);

  return (
    <div className="container">
      <div className="card">
        <h2>Dashboard</h2>

        <Table data={employees} refresh={fetchData} />
      </div>
    </div>
  );
}
``
"use client";

import { useState } from "react";

export default function Form() {
  const [form, setForm] = useState({
    name: "",
    role: "",
    hardware: "STANDARD",
  });

  const handleChange = (e: any) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const submit = async (e: any) => {
    e.preventDefault();

    await fetch("http://localhost:3001/employees", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(form),
    });

    alert("Created ✅");
  };

  return (
    <form onSubmit={submit}>
      <input name="name" placeholder="Name" onChange={handleChange} />
      <input name="role" placeholder="Role" onChange={handleChange} />

      <select name="hardware" onChange={handleChange}>
        <option value="STANDARD">Standard</option>
        <option value="PREMIUM">Premium</option>
      </select>

      <button className="button btn-primary">Submit</button>
    </form>
  );
}
``
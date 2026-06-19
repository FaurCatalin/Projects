import Link from "next/link";

export default function Home() {
  return (
    <div className="container">
      <div className="card">
        <h1>Employee Onboarding</h1>

        <div style={{ marginTop: 20, display: "flex", gap: "10px" }}>
          <Link href="/create" className="button btn-primary">
            ➕ Create Employee
          </Link>

          <Link href="/dashboard" className="button btn-primary">
            📊 Dashboard
          </Link>
        </div>
      </div>
    </div>
  );
}
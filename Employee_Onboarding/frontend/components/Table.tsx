export default function Table({ data, refresh }: any) {

  const update = async (id: number, action: string) => {
    await fetch(`http://localhost:3001/employees/${id}/${action}`, {
      method: "POST",
    });
    refresh();
  };

  return (
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Role</th>
          <th>Status</th>
          <th>Hardware</th>
          <th>Actions</th>
        </tr>
      </thead>

      <tbody>
        {data.map((emp: any) => (
          <tr key={emp.id}>
            <td>{emp.name}</td>
            <td>{emp.role}</td>

            <td>
              <span
                style={{
                  padding: "5px 10px",
                  borderRadius: "6px",
                  color: "white",
                  background:
                    emp.status === "COMPLETED"
                      ? "#10b981" // verde
                      : emp.status === "NEEDS_REWORK"
                      ? "#ef4444" // rosu
                      : "#f59e0b", // galben
                }}
              >
                {emp.status}
              </span>
            </td>

            <td>{emp.hardware}</td>

            <td>
              {/* Manager */}
              {emp.status === "HR_SUBMITTED" && (
                <button
                  className="button btn-primary"
                  onClick={() => update(emp.id, "manager-approve")}
                >
                  Manager Approve
                </button>
              )}

              {/* Finance */}
              {emp.status === "MANAGER_APPROVED" &&
                emp.hardware === "PREMIUM" && (
                  <button
                    className="button btn-warning"
                    onClick={() => update(emp.id, "finance-approve")}
                  >
                    Finance Approve
                  </button>
                )}

              {/* IT */}
              {(emp.status === "FINANCE_APPROVED" ||
                (emp.status === "MANAGER_APPROVED" &&
                  emp.hardware === "STANDARD")) && (
                <button
                  className="button btn-success"
                  onClick={() => update(emp.id, "it-done")}
                >
                  IT Done
                </button>
              )}

              {/* Reject */}
              {emp.status !== "COMPLETED" &&
                emp.status !== "NEEDS_REWORK" && (
                  <button
                    className="button btn-danger"
                    onClick={() => update(emp.id, "reject")}
                  >
                    Reject
                  </button>
                )}

              {/* 🔵 RESUBMIT */}
              {emp.status === "NEEDS_REWORK" && (
                <button
                  className="button btn-primary"
                  onClick={() => update(emp.id, "resubmit")}
                >
                  Resubmit
                </button>
              )}
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
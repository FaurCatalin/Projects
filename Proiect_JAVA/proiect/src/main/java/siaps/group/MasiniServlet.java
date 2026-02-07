package siaps.group;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/masini")
public class MasiniServlet extends HttpServlet {

    MasinaDAO dao = new MasinaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (req.getSession().getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }

        Map<String,String> filters = new HashMap<>();
        filters.put("marca", req.getParameter("marca"));
        filters.put("culoare", req.getParameter("culoare"));
        filters.put("tipulDeCombustibil", req.getParameter("combustibil"));

        boolean hasFilter = filters.values().stream().anyMatch(v -> v != null && !v.isEmpty());

        if (hasFilter) {
            req.setAttribute("masini", dao.findByFilters(filters));
            req.setAttribute("msg", "Rezultatele filtrate");
        } else {
            req.setAttribute("masini", dao.findAll());
            req.setAttribute("msg", "Toate mașinile");
        }

        req.getRequestDispatcher("masini.jsp").forward(req, resp);
    }
}

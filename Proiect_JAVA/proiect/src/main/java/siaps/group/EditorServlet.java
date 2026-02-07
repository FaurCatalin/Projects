package siaps.group;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editor")
public class EditorServlet extends HttpServlet {

    MasinaDAO dao = new MasinaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilizator u = (Utilizator) req.getSession().getAttribute("user");

        if (u == null || !u.getRol().equals("ROLE_EDITOR")) {
            resp.sendError(403, "Acces interzis");
            return;
        }

        // if edit=NR_INMATRICULARE → încarcam in formular
        String editId = req.getParameter("edit");
        if (editId != null) {
            Masina m = dao.findById(editId);
            req.setAttribute("editMasina", m);
        }

        // if delete=NR → stergem
        String deleteId = req.getParameter("delete");
        if (deleteId != null) {
            dao.delete(deleteId);
            req.setAttribute("msg", "Mașină ștearsă");
        }

        // trimitem lista completa
        req.setAttribute("masini", dao.findAll());

        req.getRequestDispatcher("editor.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilizator u = (Utilizator) req.getSession().getAttribute("user");

        if (u == null || !u.getRol().equals("ROLE_EDITOR")) {
            resp.sendError(403, "Acces interzis");
            return;
        }

        String nr = req.getParameter("nrInmatriculare");

        Masina m = new Masina(
                nr,
                req.getParameter("marca"),
                req.getParameter("model")
        );

        m.setCuloare(req.getParameter("culoare"));
        m.setId_utilizator(u.getId_utilizator());

        try { m.setAnulFabricatiei(Integer.valueOf(req.getParameter("anulFabricatiei"))); } catch(Exception ignored){}
        try { m.setCapacitateaCilindrica(Integer.valueOf(req.getParameter("capacitateaCilindrica"))); } catch(Exception ignored){}
        try { m.setPuterea(Integer.valueOf(req.getParameter("puterea"))); } catch(Exception ignored){}
        try { m.setCuplul(Integer.valueOf(req.getParameter("cuplul"))); } catch(Exception ignored){}
        try { m.setVolumulPortbagajului(Integer.valueOf(req.getParameter("volumulPortbagajului"))); } catch(Exception ignored){}
        try { m.setPret(Double.valueOf(req.getParameter("pret"))); } catch(Exception ignored){}

        m.setTipulDeCombustibil(req.getParameter("tipulDeCombustibil"));

        dao.saveOrUpdate(m);

        req.setAttribute("msg", "Mașină salvată / actualizată");
        req.setAttribute("masini", dao.findAll());
        req.getRequestDispatcher("editor.jsp").forward(req, resp);
    }
}

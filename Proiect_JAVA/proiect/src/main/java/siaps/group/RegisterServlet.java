package siaps.group;

import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    UtilizatorDAO dao = new UtilizatorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String nume = req.getParameter("nume");
        String username = req.getParameter("username");
        String parola = req.getParameter("password");

        if (nume.isEmpty() || username.isEmpty() || parola.isEmpty()) {
            req.setAttribute("error", "Toate câmpurile sunt obligatorii.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // verificare dacă există utilizatorul
        if (dao.findByUsername(username) != null) {
            req.setAttribute("error", "Username-ul există deja.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // hash parola
        String hash = BCrypt.hashpw(parola, BCrypt.gensalt());

        Utilizator u = new Utilizator(
                nume,
                username,
                hash,
                "ROLE_USER"
        );

        dao.save(u);

        req.setAttribute("msg", "Cont creat cu succes! Te poți autentifica.");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}

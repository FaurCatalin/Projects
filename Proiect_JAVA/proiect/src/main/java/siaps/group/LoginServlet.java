package siaps.group;

import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    UtilizatorDAO dao = new UtilizatorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        
        //Pentru a calcula hash-ul in functie de parola
        //String hash = BCrypt.hashpw("1234", BCrypt.gensalt());

        Utilizator u = dao.findByUsername(user);
        
        if (u == null || !BCrypt.checkpw(pass, u.getParola())) {
            req.setAttribute("error", "Credentiale gresite");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        req.getSession(true).setAttribute("user", u);
        resp.sendRedirect("masini");
    }
}

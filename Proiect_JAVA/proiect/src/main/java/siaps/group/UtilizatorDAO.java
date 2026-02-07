package siaps.group;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UtilizatorDAO {

    public Utilizator findByUsername(String username) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Query<Utilizator> q = s.createQuery(
                "from Utilizator where utilizator = :u", Utilizator.class);
        q.setParameter("u", username);
        Utilizator u = q.uniqueResult();
        s.close();
        return u;
    }
    
    public void save(Utilizator u) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = s.beginTransaction();
        s.save(u);
        tx.commit();
        s.close();
    }
}

package siaps.group;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.*;

public class MasinaDAO {

    public List<Masina> findAll() {
        Session s = HibernateUtil.getSessionFactory().openSession();
        List<Masina> list = s.createQuery("from Masina", Masina.class).list();
        s.close();
        return list;
    }
    
    public Masina findById(String nr) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Masina m = s.get(Masina.class, nr);
        s.close();
        return m;
    }

    public List<Masina> findByFilters(Map<String,String> filters) {
        StringBuilder hql = new StringBuilder("from Masina m where 1=1");

        for (String key : filters.keySet()) {
            String val = filters.get(key);
            if (val != null && !val.isEmpty()) {
                hql.append(" and m.").append(key).append(" like :").append(key);
            }
        }

        Session s = HibernateUtil.getSessionFactory().openSession();
        Query<Masina> q = s.createQuery(hql.toString(), Masina.class);

        for (String key : filters.keySet()) {
            String val = filters.get(key);
            if (val != null && !val.isEmpty()) {
                q.setParameter(key, "%" + val + "%");
            }
        }

        List<Masina> list = q.list();
        s.close();
        return list;
    }

    public void saveOrUpdate(Masina m) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = s.beginTransaction();
        s.saveOrUpdate(m);
        tx.commit();
        s.close();
    }

    public void delete(String nr) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = s.beginTransaction();
        Masina m = s.get(Masina.class, nr);
        if (m != null) s.delete(m);
        tx.commit();
        s.close();
    }
}

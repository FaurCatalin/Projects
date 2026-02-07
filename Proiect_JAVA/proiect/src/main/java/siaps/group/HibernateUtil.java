package siaps.group;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static final SessionFactory sf = build();

    private static SessionFactory build() {
        try {
            return new Configuration().configure().buildSessionFactory();
        } catch (Exception e) {
            throw new RuntimeException("SessionFactory error: " + e);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sf;
    }
}

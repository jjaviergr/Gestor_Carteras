package BD;


import POJOS.POJO_B.Visitas;
import es.cartera.HibernateUtil;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author pc
 */
public class Op_Visitas {



    public static void add(POJOS.POJO_B.Visitas u) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        session.save(u); //almacena el objeto en contexto de persistencia
        tx.commit(); //confirma transacción (sincronización con base de datos)
        session.close();
    }

    public static Visitas find(int user_id,int empresa_id) {
        Visitas resultado = null;

        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        try {
            //Query query = session.createQuery(hql);
            Criteria cs = session.createCriteria(Visitas.class);
            cs.add(Restrictions.eq("usuarios_id", user_id));
            cs.add(Restrictions.eq("empresas_id", empresa_id));
            List results = cs.list();
            //tx.commit();
            if (!results.isEmpty()) {

                resultado = (Visitas) results.get(0);
            }

        } catch (Exception e) {

        } finally {
            session.close();
        }
        return (resultado);
    }

    public static List list() {
        List results = null;

        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        try {
            String hql="from Visitas";
            Query query = session.createQuery(hql);
                        
            results = query.list();
            

        } catch (Exception e) {

        } finally {
            session.close();
        }
        return (results);
    }

//    public static Visitas find(String login) {
//        Visitas resultado = null;
//
//        SessionFactory sfactory = HibernateUtil.getSessionFactory();
//        Session session = sfactory.openSession();
//        try {
//            //Query query = session.createQuery(hql);
//            Criteria cs = session.createCriteria(Visitas.class);
//            cs.add(Restrictions.eq("login", login));
//            List results = cs.list();
//            //tx.commit();
//            if (!results.isEmpty()) {
//
//                resultado = (Visitas) results.get(0);
//            }
//
//        } catch (Exception e) {
//
//        } finally {
//            session.close();
//        }
//        return (resultado);
//    }

    public static void update(String id, POJOS.POJO_B.Visitas u) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        POJOS.POJO_B.Visitas old_user = null;

        old_user = (POJOS.POJO_B.Visitas) session.load(POJOS.POJO_B.Visitas.class, id);

        u.setId(old_user.getId());

        session.update(u); // modifica el objeto

        tx.commit(); //confirma transacción (sincronización con base de datos)

        session.close();
    }

    public static void delete(String id) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        POJOS.POJO_B.Visitas u = (POJOS.POJO_B.Visitas) session.load(POJOS.POJO_B.Visitas.class, id);
        session.delete(u); // elimina el objeto

        tx.commit();
        session.close();

    }

    
    

}

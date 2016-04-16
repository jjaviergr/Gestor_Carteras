package BD;

import POJOS.POJO_B.Usuarios;
import es.cartera.HibernateUtil;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author pc
 */
public class Op_Usuarios {

    public static void add(POJOS.POJO_B.Usuarios u) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        session.save(u); //almacena el objeto en contexto de persistencia
        tx.commit(); //confirma transacción (sincronización con base de datos)
        session.close();
    }

    public static Usuarios find(int id) {
        Usuarios resultado = null;

        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        try {
            //Query query = session.createQuery(hql);
            Criteria cs = session.createCriteria(Usuarios.class);
            cs.add(Restrictions.eq("id", id));
            List results = cs.list();
            //tx.commit();
            if (!results.isEmpty()) {

                resultado = (Usuarios) results.get(0);
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
            String hql="from Usuarios";
            Query query = session.createQuery(hql);
                        
            results = query.list();
            

        } catch (Exception e) {

        } finally {
            session.close();
        }
        return (results);
    }

    public static Usuarios find(String login) {
        Usuarios resultado = null;

        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        try {
            //Query query = session.createQuery(hql);
            Criteria cs = session.createCriteria(Usuarios.class);
            cs.add(Restrictions.eq("login", login));
            List results = cs.list();
            //tx.commit();
            if (!results.isEmpty()) {

                resultado = (Usuarios) results.get(0);
            }

        } catch (Exception e) {

        } finally {
            session.close();
        }
        return (resultado);
    }

    public static void update(String id, POJOS.POJO_B.Usuarios u) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        POJOS.POJO_B.Usuarios old_user = null;

        old_user = (POJOS.POJO_B.Usuarios) session.load(POJOS.POJO_B.Usuarios.class, id);

        u.setId(old_user.getId());

        session.update(u); // modifica el objeto

        tx.commit(); //confirma transacción (sincronización con base de datos)

        session.close();
    }

    public static void delete(String id) {
        SessionFactory sfactory = HibernateUtil.getSessionFactory();
        Session session = sfactory.openSession();
        Transaction tx = session.beginTransaction();

        POJOS.POJO_B.Usuarios u = (POJOS.POJO_B.Usuarios) session.load(POJOS.POJO_B.Usuarios.class, id);
        session.delete(u); // elimina el objeto

        tx.commit();
        session.close();

    }

    public static boolean validar(String login, String pass) {
        POJOS.POJO_B.Usuarios user = Op_Usuarios.find(login);
        if (user != null) {
            if (user.getPass().matches(pass)) {
                return true;
            }
        }
        return false;
    }

    public static String imprimir(Usuarios u) {
        String separador = ";";
        String cadena = u.getLogin() + separador;
        cadena += u.getNif() + separador;
        cadena += u.getNombre() + separador + "\n";
        return (cadena);

    }

    /*
     public static void inserta()
    {
        
    }
    
    //Eliminar un objeto Empleados de la BD (por ejemplo el empleado 4465)
    public static void borra()
    {
        
    }
    
    //Modificar el salario y comisión de un objeto Empleados de la BD 
    //(empleado 4465, con los nuevos valores 2200 y 10 respectivamente).
    public static void actualiza()
    {
        SessionFactory sfactory=HibernateUtil.getSessionFactory();
        Session session=sfactory.openSession();
        Empleados em ;
        Transaction tx=session.beginTransaction();
        em = (Empleados) session.load(Empleados.class, (short) 4465);
        
        em.setSalario((float)2200);
        em.setComision((float)10);
        session.update(em); // modifica el objeto
        
        tx.commit(); //confirma transacción (sincronización con base de datos)
        
        session.close();
    }
    
    
    
    public static void imprime_Emp()
    {
        SessionFactory sfactory=HibernateUtil.getSessionFactory();
        org.hibernate.Session session=sfactory.openSession();
        System.out.println("================================================");
        System.out.println("Listado de Empleados");
        Empleados emp;
    
        Query q=session.createQuery("from Empleados");
        Iterator<?> iter = q.iterate();
        while (iter.hasNext()){
           emp=(Empleados)iter.next();
           System.out.println("=================================================");
           System.out.println("Empleado numero :"+emp.getEmpNo());
           System.out.println("Nombre :"+emp.getApellido());
           System.out.println("Oficio :"+emp.getOficio());
           System.out.println("Departamentos :"+emp.getDepartamentos()); 
           System.out.println("Salario :"+emp.getSalario());
           System.out.println("Comisión :"+emp.getComision());
        }
        System.out.println("=================================================");
       session.close();
        
        
    }*/
}

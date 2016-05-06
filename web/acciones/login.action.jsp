<%@page import="es.cartera.Md5"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="POJOS.Usuarios"%>
<%@page import="BD.Op_Usuarios"%>
<%
    
    String login = request.getParameter("usuario"); 
    String pass = request.getParameter("pass");
    
    if ( login == null || login.isEmpty() ){
        response.sendRedirect("../login.jsp?error=1");
        return;
    }
    
    if ( pass == null || pass.isEmpty() ){
        response.sendRedirect("../login.jsp?error=2");        
        return;
    } 
    
    try
    {   
        /*Si el usuario no es valido lo hecho fuera*/        
        if ( !Op_Usuarios.validar(login, Md5.getStringMessageDigest(pass,Md5.MD5))){
            response.sendRedirect("../login.jsp?error=3");
            return;
        }
        
        /*Si el usuario si es valido grabo su cookie***/
        POJOS.Usuarios usr=BD.Op_Usuarios.find(login);
        session.setAttribute("uid", usr.getId() );
        session.setAttribute("isLogin", true);
        if ( !Op_Usuarios.esAdm(login))
        {           
            response.sendRedirect("../menu.jsp");
            return;
         }
         else
         {
            response.sendRedirect("../menu_adm.jsp");    
         }

    }
    catch (Exception e)
    {
        /*
       String mensaje=e.toString();
       response.sendRedirect("../login.jsp?error="+mensaje);
        */
        response.sendRedirect("../login.jsp?error=4");      
    }
    
%>

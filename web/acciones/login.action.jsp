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
    {   /*
        Boolean mensaje;
        mensaje=Op_Usuarios.validar(login, Md5.getStringMessageDigest(pass,Md5.MD5));
        
        response.sendRedirect("../login.jsp?error="+mensaje);*/
        
        if ( !Op_Usuarios.validar(login, Md5.getStringMessageDigest(pass,Md5.MD5))){
            response.sendRedirect("../login.jsp?error=3");
            return;
        }
        
        
        POJOS.Usuarios usr=BD.Op_Usuarios.find(login);
        session.setAttribute("uid", usr.getId() );
        session.setAttribute("isLogin", true);
        response.sendRedirect("../menu.jsp");
        return;

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

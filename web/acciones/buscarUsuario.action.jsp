<%@page import="POJOS.Usuarios"%>
<%@page import="BD.Op_Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String login = request.getParameter("login");
   
    try{
        
        Usuarios emp=Op_Usuarios.find(login);
        response.sendRedirect("../nuevo-usuario.jsp?update="+ emp.getId());
    }
    catch(Exception e){
        response.sendRedirect("../usuarios.jsp?error=4");
    }
%>
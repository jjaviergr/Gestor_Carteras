<%@page import="POJOS.Usuarios"%>
<%@page import="java.util.List"%>
<%@page import="BD.Op_Usuarios"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List listado = Op_Usuarios.list();
    int n_usuarios = Op_Usuarios.list().size();
    int nPaginas = (n_usuarios / 10);
    if (n_usuarios % 10 != 0) {
        nPaginas++;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administración de usuarios</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/nyroModal.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/ui/jquery-ui-1.8.21.custom.css" />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>        
        <script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript" src="js/jquery.nyroModal.custom.min.js"></script>
        <script type="text/javascript" src="js/jquery.nyroModal-ie6.min.js"></script>
        <script >
            $(document).ready(function () {
                $(".nyroModal").nyroModal();
                $("input:submit").button();
                $("#frmBuscar").dialog({autoOpen: false, modal: true, resizable: false});
            <%
                   if (request.getParameter("error") != null
                           && request.getParameter("error").equals("4")) { %>
                $("#error4").dialog({show: "Scale", hide: "Flod", autoOpen: true, modal: true, width: 350, height: 'auto', resizable: false,
                    buttons: {"Aceptar":
                                function () {
                                    $(this).dialog('close');
                                }
                    }
                });
            <%}%>
            });
            function Confirmar() {
                return confirm('¿Estas seguro que deseas borrar al usuario?');
            }
        </script>
    </head>
    <body>
        <div id="pagina">            
            <%@include file="header.jsp"%>
            <div id="toolbar">      
                <div class="m_tootlbar">                    
                    <div id="toolbar_botones">
                        <ul>
                            <li>
                                <a href="nuevo-usuario.jsp">
                                   <span class="icono-32-add"></span>
                                    Añadir Usuario
                                </a>
                            </li><!--
                                <li>
                                    <a href="acciones_usuarios_ed.jsp">
                                        <span class="icono-32-usuarios"></span>
                                        Editar Usuario
                                    </a>
                                </li>-->
                            <li>
                                <a href="#" onclick="$('#frmBuscar').dialog('open');">
                                    <span class="icono-32-visitas"></span>
                                    Buscar Usuario
                                </a>                                
                            </li>
                            
                            <li>
                                <a href="acciones/usuarios_cambiar_pass.jsp">
                                   <span class="icono-32-perfil"></span>
                                    Cambiar Credenciales Usuario
                                </a>                                
                            </li>                            
                            <li>
                                <a href="acciones/logout.action.jsp">
                                    <span class="icono-32-salir"></span>
                                    Salir 
                                </a>                                
                            </li>
                            
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-menu">
                        <h2>Menu de Administración</h2>
                    </div>                    
                </div>
            </div>
             <div id="content">
                <table class="listado">
                    <thead>
                        <tr>
                            <th style="display:none">Id</th>
                            <th width="80p">Login</th>
                            <th>Nombre</th>
                            <th width="80p">Apellidos</th>
                            <th width="200p">Fecha Nacimiento</th>
                            <th width="80p">Fecha Ultimo Acceso</th>
                            <th width="80p">Oper.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < listado.size(); i++) {
                                Usuarios e = (Usuarios) listado.get(i);
                        %>

                        <tr>
                            <td style="display:none"><%=e.getId()%></td>
                            <td><%=e.getLogin()%></td>
                            <td><%=e.getNombre()%></td>
                            <td><%=e.getApellidos()%></td>                            
                            <td align="center"><%
                                   SimpleDateFormat fecha = new SimpleDateFormat("dd/MM/yyyy");
                                   try
                                   {
                                      out.print(fecha.format(e.getFnac().getTime()));
                                   }
                                   catch (Exception ex)
                                   {
                                       out.print("Sin fecha");
                                   }
                                   
                            %>
                                   
                            </td>
                            <td align="center"><%
                                   try
                                   {
                                      out.print(fecha.format(e.getFu().getTime()));
                                   }
                                   catch (Exception ex)
                                   {
                                       out.print("Sin fecha");
                                   }%>
                            </td>
                            <td align="center">
                                <a href="nuevo-usuario.jsp?update=<%=e.getId()%>">
                                    <img src="img/icono16/editar.png" alt="editar" title="Editar usuario" />
                                </a>
                                <a href="acciones/borrarUsuario.action.jsp?id=<%=e.getId()%>" onclick="return Confirmar();"/>
                                    <img src="img/icono16/borrar.png" alt="editar" title="Borrar la usuario" />
                                </a>
                                <a class="nyroModal" href="verUsuario.jsp?idUsuario=<%=e.getId()%>">
                                    <img src="img/icono16/ver.png" alt="editar" title="Ver ficha de usuario" />
                                </a>
                            </td>
                        </tr>
                        <% }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="2">
                                <h5>NºUsuarios: <%=n_usuarios%></h5>
                            </td>
                            <td colspan="5">
                                <ul class="paginar">

                                    <% for (int i = nPaginas - 1; i >= 0; i--) {%>
                                    <li><a href="usuarios.jsp?pag=<%=i%>"><%=(i + 1)%></a></li>
                                        <% } %>
                                </ul>                                
                                <span class="limpiar"></span>
                            </td>
                        </tr>
                    </tfoot>
                </table>
                <div class="limpiar"></div>
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />
        <div id="frmBuscar" title="Buscar Usuario">
            <form method="POST" action="acciones/buscarUsuario.action.jsp">
                <table style="padding: 20px">
                    <tr>
                        <td width="100">Login:</td>
                        <td width="400"><input type="text" name="login" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="Buscar Usuario"/>
                        </td>
                    </tr>

                </table>
            </form>
        </div>
        <%
    if (request.getParameter("error") != null && request.getParameter("error").equals("4")) { %>
        <div id="error4" title="Error al buscar">
            <p class="ui-state-error ui-corner-all" 
               style="padding: 0.7em; font-size: 1.1em; text-align: center">
                No existe ningun usuario con ese NIF
            </p>    
        </div>
        <% }%>
    </body>
</html>

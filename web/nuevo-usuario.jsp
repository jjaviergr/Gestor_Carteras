<%@page import="java.util.ListIterator"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="POJOS.Usuarios"%>
<%@page import="BD.Op_Usuarios"%>
<%@page import="java.util.List"%>
<%@page import="BD.Op_Usuarios"%>
<%@page import="POJOS.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuarios e = null;
    boolean inicializa = false;
    boolean error=false;
    String mensaje_Error="";
    String id_usuario=request.getParameter("update");    

    if (id_usuario!=null)
    {          
        try
        {
           inicializa=true;
           int id=Integer.parseInt(id_usuario);
           e=Op_Usuarios.find(id);
          
          
        }
        catch(Exception ex)
        {
            inicializa=false;
            error=true;
            mensaje_Error=ex.getMessage().toString();
          
        }
    }
    
    
    
    //int edit_id = -1;

    
    //inicializa = true;
       
    //e = (Usuarios) session.getAttribute("usuario");
        
   

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comerciales - Alta Nueva usuario.</title>
        <link rel="shortcut icon" href="./favicon.ico" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/estilos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/forms.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/iconos.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/posicionamiento.css" />
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/additional-methods.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#altausuario').submit(function () {
                    if (confirm("¿Estas Seguro?"))
                        return true;
                    else
                        return false;
                });
                $('#altausuario').validate({
                    rules: {
                        "nombre": {
                            "required": true,
                            "maxlength": 80
                        },
                        "direccion": {
                            "required": true,
                            "maxlength": 80
                        },
                        "provincia": {
                            "required": true,
                            "maxlength": 30
                        },
                        "poblacion": {
                            "required": true,
                            "maxlength": 30
                        },
                        "cp": {
                            "required": true,
                            "digits": true,
                            "minlength": 5,
                            "maxlength": 5
                        },
                        "tlf": {
                            "required": true,
                            "digits": true,
                            "minlength": 9,
                            "maxlength": 9
                        },
                        "contacto": {maxlength: 50}
                    },
                    messages: {
                        "nombre": {
                            "required": "Debe de escribir el nombre de la usuario",
                            "maxlength": "El numero maximo de caracteres es 80"
                        },
                        "direccion": {
                            "required": "Debe escribir una direccion",
                            "maxlength": "Tamaño maximo de caracteres es 80."
                        },
                        "provincia": {
                            "required": "Debe de escribir la Provincia",
                            "maxlength": 30
                        },
                        "poblacion": {
                            "required": "Debe de escribir la Población",
                            "maxlength": 30
                        },
                        "cp": {
                            "required": "Debe de escribir un Codigo Postal",
                            "digits": "Solo se permiten numeros.",
                            "minlength": "Codigo postal no valido",
                            "maxlength": "Codigo postal no valido"
                        },
                        "tlf": {
                            "required": "Este campo es obligatorio",
                            "digits": "Telefono incorrecto",
                            "minlength": "Telefono incorrecto",
                            "maxlength": "Telefono incorrecto"
                        },
                        "contacto": {maxlength: "Numero maximo de caracteres es de 50", }
                    }
                });
            });
            function EnviarFormulario() {
                if ($("#altausuario").valid())
                    document.forms[0].submit();
            }
        </script>

    </head>
    <body>
        <div id="pagina">
            <jsp:directive.include file="header.jsp" />
            <div id="toolbar">      
                <div class="m_tootlbar">                    
                    <div id="toolbar_botones">
                        <ul>
                            <li>
                                <a href="#" onclick="EnviarFormulario();">
                                    <span class="icono-32-aceptar"></span>
                                    Aceptar
                                </a>
                            </li>
                            <li>
                                <a href="usuarios.jsp">
                                    <span class="icono-32-cancelar"></span>
                                    Cancelar
                                </a>                                
                            </li>
                        </ul>
                        <div class="limpiar"></div>
                    </div>
                    <div class="toolbar_titulo icono-48-usuarios">
                        <h2>Nuevo Usuario</h2>
                    </div>                    
                </div>
            </div>
            <div id="content">
                <%if (error ) {%>
                <div class="marcoError">
                    <p><%=mensaje_Error%></p>
                </div>
                <% }%>
                <form id="altausuario" method="POST" action="<% if (!inicializa)
                                                                   out.print("acciones/altausuario.action.jsp"); 
                else out.print("acciones/editarusuario.action.jsp");
                      %>">">
                    <% if (e != null && e.getId() != -1) {%>
                    <input type="hidden" name="id" value="<%=e.getId()%>" />
                    <% }%>
                    <table class="altaUsuario"><!--login,  nombre,  apellidos,  fnac,  fu,  pass,  nif,  esAdm,  vis-->
                        <tr>
                            <td width="130"><label>Login.:</label></td>
                            <td><input type="text" name="login" value="<%=inicializa ? e.getLogin(): ""%>" 
                                   
                                       />
                            <input type="hidden" name="pass" value=""/>     
                            </td>
                        </tr>
                       
                        <tr>
                            <td><label>Nombre:</label></td>
                            <td><input type="text" name="nombre" value="<%=inicializa ? e.getNombre() : ""%>" /></td>
                        </tr>
                        <tr>
                            <td><label>Apellidos:</label></td>
                            <td><input type="text" name="apellidos" value="<%=inicializa ? e.getApellidos(): ""%>"/></td>
                        </tr>
                        <tr>
                            <td> <label>Fecha Nacimiento:</label></td>
                            <td>
                                <input type="date" name="Fecha Nacimiento" value="<%
                                if (inicializa)
                                {
                                    SimpleDateFormat fecha = new SimpleDateFormat("yyyy-MM-dd");
                                    out.print(fecha.format(e.getFnac().getTime()));
                                }
                                else
                                {
                                    
                                }
                                %>"
                                />
                            </td>
                        </tr>
                        <tr>
                            <td><label>NIF:</label></td>
                            <td><input type="text" name="nif" value="<%=inicializa ? e.getNif() : ""%>"/></td>
                        </tr>
                        <tr>
                            <td><label>Rol de Adm:</label></td>
                            <td>                      <!--<input type="text" name="cp" value="<%//=inicializa ? e.isEsAdm() : ""%>"/>-->
                                <select name="esAdm">
                                    <option value="0">SI</option>
                                    <option selected value="1">NO</option>
                                </select>
                            </td>
                        </tr>
                                                
                        <tr>
                           
                            <td>
                                <input type="hidden" name="fu"  
                                       value="<%
                                           SimpleDateFormat fecha = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
                                   out.print(fecha.format(new Date()));
                                       %>"/>
                                
                            </td>
                        </tr> 
                        
                    </table>
                </form>
            </div>
        </div>
        <jsp:directive.include file="pie.jsp" />

    </body>
</html>

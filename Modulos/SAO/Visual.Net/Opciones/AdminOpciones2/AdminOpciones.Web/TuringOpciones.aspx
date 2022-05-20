<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TuringOpciones.aspx.cs" Inherits="AdminOpciones.Web.TuringOpciones" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="head" runat="server">
    <title>AdminOpciones</title>

    <style type="text/css">
    html, body {
	    height: 100%;
	    overflow: auto;
    }
    body {
	    padding: 0;
	    margin: 0;
    }
    #silverlightControlHost {
	    height: 100%;
    }
    </style>
    <script type="text/javascript" src="Silverlight.js"></script>
    <script type="text/javascript">
        function onSilverlightError(sender, args) {
        
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            } 
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;
            
            var errMsg = "Error no controlado en la aplicación de Silverlight 2 " +  appSource + "\n" ;

            errMsg += "Código: "+ iErrorCode + "    \n";
            errMsg += "Categoría: " + errorType + "       \n";
            errMsg += "Mensaje: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError")
            {
                errMsg += "Archivo: " + args.xamlFile + "     \n";
                errMsg += "Línea: " + args.lineNumber + "     \n";
                errMsg += "Posición: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError")
            {           
                if (args.lineNumber != 0)
                {
                    errMsg += "Línea: " + args.lineNumber + "     \n";
                    errMsg += "Posición: " +  args.charPosition + "     \n";
                }
                errMsg += "Nombre de método: " + args.methodName + "     \n";
            }

            throw new Error(errMsg);
        }

        function AbreReporte(Param) {
            window.open("Reportes/Report.aspx?d=" + Param, "_blank", 'height:100%; width: 100%; min-height: 600px; min-width: 990px;');
            //window.open("Reportes/Report.aspx?=" + Param, "_blank");
        }

        function ExportaExcel(Param) {
            window.open("ExportaExcel/Exporta.aspx" + Param, "_top", 'height:100%; width: 100%; min-height: 600px; min-width: 990px;');
        }

        function ExportaTxt(Param) {
            window.open("ExportaTexto/ExportaTxt.aspx?d=" + Param, "_blank", 'height:100%; width: 100%; min-height: 600px; min-width: 990px;');
        }

        function CallThis() {

            window.location.reload(false)

        }
    </script>
</head>

<body style="margin: 0 0 0 0; vertical-align: middle; text-align: center;">
    <!-- Aquí se mostrarán los errores en tiempo de ejecución de Silverlight.
	Contendrá información de depuración y debería ocultarse o quitarse una vez completada la depuración
	<div id='errorLocation' style="font-size: small;color: Gray;"></div> -->
        <object
            width="100%" height="100%"
            type="application/x-silverlight-2" 
            data="data:application/x-silverlight-2," >
            <param name="source" value="ClientBin/AdminOpciones.xap"/>
            <param name="initParams" value="source=ClientBin/AdminOpciones.xap,user_name=<%=Request["user_name"]%>,user_password=<%=Request["user_password"]%>" />
            <param name="onerror" value="onSilverlightError" />
            <param name="background" value="white" />
            <param name="minRuntimeVersion" value="4.0.60310.0" />
            <param name="autoUpgrade" value="true" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.60310.0" 
                style="text-decoration: none;">
                <img 
                    src="http://go.microsoft.com/fwlink/?LinkId=161376" 
                    alt="Get Microsoft Silverlight" 
                    style="border-style: none"/>
            </a>
        </object>
</body>
</html>
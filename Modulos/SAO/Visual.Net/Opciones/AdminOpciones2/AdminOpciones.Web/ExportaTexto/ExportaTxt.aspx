<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExportaTxt.aspx.cs" Inherits="AdminOpciones.Web.ExportaTexto.ExportaTxt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title>Generación de Interfaces</title>
    </head>
    <body>
        <form id="form1" runat="server">
            <div id="divData">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="True" Height="379px">                
                </asp:GridView>        
              </div>       
        </form>
    </body>
</html>

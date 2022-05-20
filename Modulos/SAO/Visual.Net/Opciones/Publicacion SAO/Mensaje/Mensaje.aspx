<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mensaje.aspx.cs" Inherits="AdminOpciones.Web.Mensaje.Mensaje" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
    </head>
    <body runat="server">
        <form id="form1" runat="server">
            <div id="divMessage" runat="server">
                <asp:Panel ID="pnlMessage" runat="server" Width="993px" Height="50px">
                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" Font-Size="X-Large" />
                </asp:Panel>
                <asp:Panel ID="pnlButton" runat="server" style="float: left; vertical-align:top; text-align: center;" Width="993px" Height="20px">
                    <asp:Button ID="btnConfirmar" runat="server" Text="Yes" Font-Size="Smaller" Width="100px" Height="20px" OnClick="btnConfirmar_Click" />
                    <asp:Button ID="btnCancelar" runat="server" Text="Salir" Font-Size="Smaller" Width="100px" Height="20px" OnClick="btnCancelar_Click" />
                </asp:Panel>
            </div>
        </form>
    </body>
</html>

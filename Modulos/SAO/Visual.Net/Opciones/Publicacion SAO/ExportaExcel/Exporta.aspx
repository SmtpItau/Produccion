<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Exporta.aspx.cs" Inherits="AdminOpciones.Web.ExportaExcel.Exporta" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" Height="379px">
                <Columns>
                    <asp:BoundField HeaderText="Número Contrato" DataField="NumContrato" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Número Folio" DataField="NumFolio" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Tipo Transaccion" DataField="TipoTransaccion" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Fecha de Contrato" DataField="FechaContrato" ReadOnly="True" />
                    <asp:BoundField HeaderText="Estado" DataField="ConOpcEstDsc" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Rut Cliente" DataField="CliRut" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Dv" DataField="CliDv" ReadOnly="True"/>
                    <asp:BoundField HeaderText="Codigo Cliente" DataField="CliCod" ReadOnly="True" />
                    <asp:BoundField HeaderText="Nombre Cliente" DataField="CliNom" ReadOnly="True" />                                    			
                    <asp:BoundField HeaderText="Tipo de Contrapartida" DataField="Contrapartida" ReadOnly="True" />
                    <asp:BoundField HeaderText="Operador" DataField="Operador" ReadOnly="True" />
                    <asp:BoundField HeaderText="Nombre de la Estructura" DataField="OpcEstDsc" ReadOnly="True" />
                    <asp:BoundField HeaderText="Fecha Creacion Registro" DataField="FechaCreacionRegistro" ReadOnly="True" />
                    <asp:BoundField HeaderText="Impreso" DataField="Impreso" ReadOnly="True" Visible="False" />
                </Columns>
            </asp:GridView>        
          </div>       
    </form>
</body>
</html>



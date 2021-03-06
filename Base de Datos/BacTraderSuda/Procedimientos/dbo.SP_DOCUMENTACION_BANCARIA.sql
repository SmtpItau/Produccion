USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DOCUMENTACION_BANCARIA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DOCUMENTACION_BANCARIA]
AS
BEGIN
 SELECT 
  'TipoOperacion'  = (select descripcion from view_producto where m.motipoper=codigo_producto), 
  'NumeroOperacion'= m.monumoper,
  'RutCliente'  = m.morutcli,
  'CodigoCliente'  = m.mocodcli,
  'DvCliente'  = (select cldv from view_cliente where m.morutcli=clrut and  m.mocodcli=clcodigo ),
  'NombreCliente'  = (select clnombre from view_cliente where m.morutcli=clrut and  m.mocodcli=clcodigo ),  
  'Valor'   = sum(m.movalcomp),
  'FormaPago'  = (select glosa from view_forma_de_pago where m.moforpagi=codigo), 
  'Estado'  = m.mostatreg
  
 
 
 FROM
  MDMO M
 
 
 
 WHERE
  (m.moforpagi=2 or m.moforpagi=11)
 and  (m.motipoper='CP' or m.motipoper='RC' or m.motipoper='ICAP')
 group by m.monumoper,m.morutcli, m.mocodcli,m.motipoper,m.moforpagi,m.mostatreg 
end

GO

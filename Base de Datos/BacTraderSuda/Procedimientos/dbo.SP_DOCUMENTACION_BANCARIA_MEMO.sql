USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DOCUMENTACION_BANCARIA_MEMO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DOCUMENTACION_BANCARIA_MEMO]
AS
BEGIN
  
 SELECT
  'TipoOperacion'  = 'COMPRA',
  'NumeroOperacion'= monumope,
  'RutCliente'  = morutcli,
  'CodigoCliente'  = mocodcli,
  'DvCliente'  = cldv,
  'NombreCliente'  = clnombre,
  'Valor'   = momonpe,
  'FormaPago'  = glosa,
  'Estado'  = moestatus
 
 FROM 
  VIEW_MEMO,
  VIEW_CLIENTE,
  VIEW_FORMA_DE_PAGO
  
 WHERE 
  morutcli=clrut
 and     moentre=codigo
 and mocodcli=clcodigo
 and motipope='C'
 and (motipmer='EMPR' or motipmer='PTAS')
 and (moentre=2 or moentre=11) 
 
end


GO

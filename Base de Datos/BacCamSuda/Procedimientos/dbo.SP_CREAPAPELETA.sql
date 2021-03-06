USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAPAPELETA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CREAPAPELETA]
            ( @MODOIMPRESO CHAR(1) )
AS                            
BEGIN
SET NOCOUNT ON
  IF @MODOIMPRESO = 'X'
  BEGIN
     PRINT 'Archivo Borrado'
     SET NOCOUNT OFF
     RETURN
  END
  -- Spot
  SELECT 
         'RutEmisor'         = acrut,
         'CodigoEmisor'      = accodigo,
         'DigChkEmisor'      = acdv,
         'NombreEmisor'      = acnombre,
         'RutCliente'        = morutcli,
         'DigChkCliente'     = a.cldv,
         'NombreCliente'     = a.clnombre,
         'DireccionCliente'  = a.cldirecc,
         'fechaRecibe'       = CONVERT(CHAR(10),movaluta2,103),
         'fechaEntrega'      = CONVERT(CHAR(10),movaluta1,103),
         'MontoOpera'        = momonmo,
         'MontoUSD'          = moussme,
         'MontoCLP'          = momonpe,
         'TipoCamCie'        = moticam,
         'TipoCamTra'        = motctra,
         'PariCie'           = moparme,
         'PariTra'           = mopartr,
         'PariFin'           = moparfi,
         'Modoimpreso'       = moimpreso,
         'MonedaOpera'       = mnglosa,
         'MonedaConve'       = mocodcnv,
         'NoOpera'           = monumope,
         'TipoOpera'         = motipope,
         'Entregamos'        = CASE WHEN moentre = 0 THEN ' ' ELSE ( select glosa from view_forma_de_pago where codigo=moentre ) END,
         'Recibimos'         = CASE WHEN morecib = 0 THEN ' ' ELSE ( select glosa from view_forma_de_pago where codigo=morecib ) END,
         'Operador'          = mooper,
         'TipoCamTrF'        = motcfin,
         'Retiro'            = morecib,
         'TipoMercado'       = CONVERT(CHAR(40),motipmer),
         'Moneda'            = mocodmon,
         'Estado'            = moestatus
    INTO #TEMPAPE
    FROM MEMO
        ,VIEW_CLIENTE a
        ,VIEW_MONEDA
        ,MEAC  
   WHERE morutcli = a.clrut  
     AND mocodcli = a.clcodigo
     AND mocodmon = MnNemo
  -- Actualiza Entidad
  UPDATE #TEMPAPE
     SET Modoimpreso = @ModoImpreso,
         TipoMercado = glosa
    FROM VIEW_AYUDA_PLANILLA
   WHERE codigo_tabla = 15 
     AND codigo_caracter = SUBSTRING(RTRIM(TipoMercado),1,4)
--/////////////////////////////////////////////////
--REVISAR ESTE TROZO---
--////////////////////////////////////////////////
   --select * 
   SELECT Modoimpreso,TipoOpera,NoOpera,
          NombreCliente,MontoUSD,TipoCamCie,TipoMercado,MontoOpera
     FROM #TEMPAPE
    ORDER BY NoOpera 
--//////////////////////////////////////////////
SET NOCOUNT OFF
END   /* FIN PROCEDIMIENTO */




GO

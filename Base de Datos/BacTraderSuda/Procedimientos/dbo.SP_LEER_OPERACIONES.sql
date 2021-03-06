USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERACIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERACIONES]
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS( SELECT 1 FROM MDMO WHERE mostatreg IN('P','R') ) 
   BEGIN

      SELECT 'monumoper'       = monumoper
         ,   'motipoper'       = CASE WHEN motipoper = 'IB'  THEN (CASE WHEN momascara = 'ICAP' THEN 'CAPTACION' ELSE 'COLOCACION' END)
                                      WHEN motipoper = 'RC'  THEN 'RECOMPRA' 
                                      WHEN motipoper = 'RCA' THEN 'RECOMPRA ANT.' 
                                      WHEN motipoper = 'RVA' THEN 'REVENTA ANT.' 
                                      WHEN motipoper = 'RV'  THEN 'REVENTA'
                                      WHEN motipoper = 'VI'  THEN 'VENTA CON PACTO'
                                      WHEN motipoper = 'CI'  THEN 'COMPRA CON PACTO'
                                      WHEN motipoper = 'CP'  THEN 'COMPRA DEFINITIVA'
                                      WHEN motipoper = 'VP'  THEN 'VENTA DEFINITIVA' 
                                      ELSE motipoper 
                                 END 
         ,   'Total_operacion' = CASE WHEN motipoper = 'CP' OR motipoper = 'CI' or motipoper = 'RV' OR motipoper = 'IB' THEN movalcomp
                                      WHEN motipoper IN('VP','RVA')                                                     THEN movalven
                                      WHEN motipoper IN('VI')                                                           THEN movalinip
                                      WHEN motipoper IN('RC', 'RCA')                                                    THEN movalvenp
                                      WHEN motipoper = 'IC'                                                             THEN monominal   
                                      WHEN motipoper = 'FLI'                                                            THEN movpresen
                                 END
         ,   'mostatreg'       = mostatreg
         ,   'usuario'         = ISNULL((SELECT operador FROM VIEW_LINEA_TRANSACCION WHERE numerooperacion = monumoper 
                                                 and NumeroCorrelativo = 1 and id_sistema = 'BTR' and codigo_producto = motipoper),' ') 
      INTO      #TEMP_OPER
      FROM      MDMO          
      WHERE     mostatreg IN('P', 'R')
      AND       motipoper <> 'TM'
      ORDER BY  monumoper

      SELECT monumoper 
      ,      motipoper
      ,      Total_operacion = SUM(Total_operacion)
      ,      mostatreg
      ,      usuario
      FROM  #TEMP_OPER
      GROUP BY monumoper ,motipoper,mostatreg, usuario

   END ELSE 
   BEGIN

      SELECT 0,'',0,'',''

   END

END




GO

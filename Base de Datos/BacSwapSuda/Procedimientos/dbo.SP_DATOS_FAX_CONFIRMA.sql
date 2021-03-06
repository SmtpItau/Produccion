USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DATOS_FAX_CONFIRMA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--sp_helptext SP_DATOS_FAX_CONFIRMA '20140408'



CREATE PROCEDURE [dbo].[SP_DATOS_FAX_CONFIRMA]   
   (   @Fecha_Reporte  DATETIME   )  
  
AS   
BEGIN  
   -- MAP 20080708 Permite emitir confirmación estando parado cualquier dia.  
   --              ojo que la cartera evoluaciona !!!  
   -- SP_DATOS_FAX_CONFIRMA '20080529'  
   SET NOCOUNT ON     
  
   DECLARE @afecproc CHAR(10)  
   ,       @afecant  CHAR(10)  
   ,       @afecprox CHAR(10)  
   ,       @Compra   INTEGER  
   ,       @Venta    INTEGER  
  
   SELECT  @afecant = CONVERT(CHAR(10), fechaant,  112)  
   ,       @afecproc = CONVERT(CHAR(10), fechaproc, 112)  
   ,       @afecprox = fechaprox  
   FROM    SWAPGENERAL  
  
     SELECT DISTINCT   
             'SWP'  = ISNULL((CASE WHEN tipo_swap = 1 THEN 'SWAP DE TASAS    '  
                                               WHEN tipo_swap = 2 THEN 'SWAP DE MONEDAS  '  
                                               WHEN tipo_swap = 3 THEN 'FRA              '  
                                               WHEN tipo_swap = 4 THEN 'PROMEDIO CAMARA  '  
                                  END),'')  
      ,     'Tipo_operacion'    = SPACE(70)  
      ,     'numero_operacion'  = numero_operacion  
      ,     'fecha_contrato'    = fecha_cierre  
      ,     'Plazo'  = DATEDIFF(DAY, fecha_cierre,   fecha_termino)  
      ,     'Residual'         = DATEDIFF(DAY, @Fecha_Reporte, fecha_termino)  
      ,     'fec_term'         = fecha_termino     
      ,     'cliente'         = clnombre  
      ,     'Tipo_Tasa_Recibe'  = ISNULL((SELECT DISTINCT compra_codigo_tasa FROM bacswapsuda..CARTERA C2 WHERE C1.Numero_Operacion = C2.NUmero_OPeracion AND Tipo_Flujo = 1),-1)	--- PRD-3166
      ,     'Tipo_Tasa_Paga'    = ISNULL((SELECT DISTINCT venta_codigo_tasa  FROM bacswapsuda..CARTERA C2 WHERE C1.Numero_Operacion = C2.NUmero_OPeracion AND Tipo_Flujo = 2),-1) 	--- PRD-3166
	  ,		Impreso		=	Bacfwdsuda.dbo.Fn_Estatus_Impreso( 'PCS', numero_operacion )
      INTO  #MOVDIR  
      FROM  CARTERA C1  
            INNER JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo  
      WHERE Fecha_Cierre = @Fecha_Reporte -- @afecproc  
      AND   Estado             <> 'C'  
  
	  --- Eliminar los casos en que alguna de las patas era NULL.  PRD-3166
	  DELETE FROM #MOVDIR
	  WHERE Tipo_Tasa_Recibe = -1 OR Tipo_Tasa_Paga = -1

      UPDATE #MOVDIR   
         SET Tipo_operacion = (CASE WHEN Tipo_Tasa_Recibe =  0 AND Tipo_Tasa_Paga =  0 THEN 'FIJA/FIJA'  
                                    WHEN Tipo_Tasa_Recibe =  0 AND Tipo_Tasa_Paga <> 0 THEN 'FIJA/VARIABLE'  
                                    WHEN Tipo_Tasa_Recibe <> 0 AND Tipo_Tasa_Paga =  0 THEN 'VARIABLE/FIJA'  
                                    WHEN Tipo_Tasa_Recibe <> 0 AND Tipo_Tasa_Paga <> 0 THEN 'VARIABLE/VARIABLE'  
                               END)  
      SELECT * FROM #Movdir  
  
END  


GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_LINEA_CREDITO_TURING_TOTALES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_LINEA_CREDITO_TURING_TOTALES]    
                          @Rut_Cliente DECIMAL(10,0)
						 ,@Codigo      int


AS    
BEGIN    
    
	SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : EXTRAER MONTOS DE LINEA DE CREDITO TURING TOTALES           */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 23/09/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS LINEAS SISTEMAS PARA OPCIONES                           */
   /*-----------------------------------------------------------------------------*/
   
	    
	 SELECT MON.mnnemo             AS MONEDA
           ,LIN.TotalAsignado      AS TOTAL_LINEA
           ,LIN.TotalOcupado       AS TOTAL_OCUPADO
           ,LIN.TotalDisponible    AS TOTAL_DISPONIBLE
		   ,LIN.TotalExceso        AS TOTAL_EXCESO
		      ,(SELECT ISNULL(CONVERT(INT,MAX(plazohasta)),0) 
		        FROM BacLineas.dbo.linea_producto_por_plazo 
		        WHERE Rut_Cliente = @RUT_CLIENTE AND Codigo_Cliente = @Codigo  AND Id_Sistema ='OPT') AS PLAZO
		   ,LIN.Bloqueado          AS BLOQUEADO
		      ,Convert(varchar(10),FechaFinContrato,105) AS F_VENC_LINEA
	     FROM BACLINEAS..LINEA_SISTEMA  LIN 
      INNER JOIN
	        MONEDA                    MON WITH(NOLOCK)
		 ON MON.mncodmon   = LIN.Moneda 
      WHERE Rut_Cliente    = @Rut_Cliente
	    AND Codigo_Cliente = @Codigo
		   AND Id_Sistema IN ('OPT')


END

	  
		   





GO

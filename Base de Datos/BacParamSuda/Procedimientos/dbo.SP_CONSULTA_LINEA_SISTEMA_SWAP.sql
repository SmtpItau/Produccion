USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_LINEA_SISTEMA_SWAP]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CONSULTA_LINEA_SISTEMA_SWAP]    
                        @RUT_CLIENTE    DECIMAL(10,0)
					   ,@CODIGO_CLIENTE INT
					   ,@METODOLOGIA    INT

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : POR MEDIO DE METODOLOGIA SE EXTRAEN REGISTROS DE LINEA      */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 05/10/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*------------------------------------------------------------------------------------*/
   /* SI LA METODOLOGIA ENVIADA ES 1 Y 4 CONSULTA LINEA SISTEMAS PARA PRODUCTOS SWAP     */
   /*------------------------------------------------------------------------------------*/
     IF @METODOLOGIA IN(1,4) BEGIN

	    SELECT MON.mnnemo             AS MONEDA
		      ,LIN.TotalAsignado      AS TOTAL_LINEA
              ,LIN.TotalOcupado       AS TOTAL_OCUPADO
              ,LIN.TotalDisponible    AS TOTAL_DISPONIBLE
		      ,LIN.TotalExceso        AS TOTAL_EXCESO
		      ,(SELECT ISNULL(CONVERT(INT, MAX(plazohasta)),0) 
		        FROM BacLineas.dbo.linea_producto_por_plazo 
				WHERE Rut_Cliente = @RUT_CLIENTE AND Codigo_Cliente = @CODIGO_CLIENTE  AND Id_Sistema ='BFW') AS PLAZO
		      ,LIN.Bloqueado          AS BLOQUEADO
		      ,Convert(varchar(10),FechaFinContrato,105) AS F_VENC_LINEA
	      FROM BACLINEAS..LINEA_SISTEMA  LIN 
         INNER JOIN
	           MONEDA                    MON WITH(NOLOCK)
		    ON MON.mncodmon         = LIN.Moneda 
		 WHERE Rut_Cliente          = @RUT_CLIENTE
		   AND Codigo_Cliente       = @CODIGO_CLIENTE
		   AND Id_Sistema IN ('PCS')

	 END
    
   /*----------------------------------------------------------------------------------------*/
   /* SI LA METODOLOGIA ENVIADA ES 2,3 o 5 CONSULTA LINEA SISTEMAS PARA PRODUCTOS DERIVADOS  */
   /*----------------------------------------------------------------------------------------*/
     IF @METODOLOGIA IN(2,3,5) BEGIN


	    SELECT MON.mnnemo             AS MONEDA
		      ,LIN.TotalAsignado      AS TOTAL_LINEA
              ,LIN.TotalOcupado       AS TOTAL_OCUPADO
              ,LIN.TotalDisponible    AS TOTAL_DISPONIBLE
		      ,LIN.TotalExceso        AS TOTAL_EXCESO
		      ,(SELECT ISNULL(CONVERT(INT,MAX(plazohasta)),0) 
		        FROM BacLineas.dbo.linea_producto_por_plazo 
		        WHERE Rut_Cliente = @RUT_CLIENTE AND Codigo_Cliente = @CODIGO_CLIENTE  AND Id_Sistema ='DRV') AS PLAZO
		      ,LIN.Bloqueado          AS BLOQUEADO
		      ,Convert(varchar(10),FechaFinContrato,105) AS F_VENC_LINEA
	      FROM BACLINEAS..LINEA_SISTEMA  LIN 
         INNER JOIN
	           MONEDA                    MON WITH(NOLOCK)
		    ON MON.mncodmon         = LIN.Moneda 
		 WHERE Rut_Cliente          = @RUT_CLIENTE
		   AND Codigo_Cliente       = @CODIGO_CLIENTE
		   AND Id_Sistema IN ('DRV')

	 END

END

GO

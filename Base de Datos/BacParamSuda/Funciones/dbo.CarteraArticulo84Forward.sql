USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[CarteraArticulo84Forward]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[CarteraArticulo84Forward](@RUT_CLIENTE    NUMERIC (10,0)
                                                ,@FECHA_PROCESO  DATETIME)


  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns  @FORWARD TABLE
	 (NUMERO_OPERACION        NUMERIC(10,0)
	 ,MODULO                  CHAR(04)
	 ,FECHA_PROCESO           DATETIME
	 ,RUT_CLIENTE             NUMERIC(10,0)
	 ,COD_CLIENTE             INT
	 ,NOCIONAL                FLOAT
	 ,FECHA_CIERRE            DATETIME
	 ,FECHA_INICIO            DATETIME
	 ,TIR                     FLOAT
	 ,COD_MONEDA              INT
	 ,COD_PRODUCTO            VARCHAR(10)
	 ,VIGENCIA_DIAS           INT
	 ,MONTO_1                 FLOAT)




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA FORDWARD                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 13/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* MONEDAS PRIMARIAS                                                           */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @FORWARD
     SELECT FWD.canumoper                                      AS NUMERO_OPERACION
          ,'BFW'                                               AS MODULO 
          ,@FECHA_PROCESO                                      AS FECHA_PROCESO
          ,FWD.cacodigo                                        AS RUT_CLIENTE
          ,FWD.cacodcli                                        AS COD_CLIENTE      
          ,FWD.camtomon1                                       AS NOCIONAL
          ,FWD.cafecha                                         AS FECHA_CIERRE                    
          ,FWD.fechaemision                                    AS FECHA_INICIO
          ,FWD.catasaufclp                                     AS TIR
          ,FWD.cacodmon1                                       AS COD_MONEDA
          ,FWD.cacodpos1                                       AS COD_PRODUCTO
          ,DATEDIFF(DAY, @FECHA_PROCESO, FWD.cafecvcto)        AS VIGENCIA_DIAS
          ,FWD.fRes_Obtenido                                   AS VALOR_RAZONABLE     
       FROM BacFwdSuda..MFCA    FWD WITH(NOLOCK)
      WHERE FWD.cacodigo      = @RUT_CLIENTE


 Return

 END


GO

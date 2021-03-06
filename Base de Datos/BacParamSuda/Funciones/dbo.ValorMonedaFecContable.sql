USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ValorMonedaFecContable]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[ValorMonedaFecContable](@FECHA_CONTABLE DATETIME)


  /*-----------------------------------------------------------------------------*/
  /*CREACION DE TABLA DE SALIDA                                                  */
  /*-----------------------------------------------------------------------------*/
    returns @TMP_VALOR_MONEDA_ART84_DERIVADOS TABLE
	(vmfecha    DATETIME
	,vmcodigo   INT
	,vmvalor    NUMERIC (18,8))


 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA FORDWARD                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 13/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* VALORES DE MONEDAS BASADO EN LA FECHA ENVIADA                               */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS
     SELECT vmfecha
	      , vmcodigo
		  , vmvalor    
       FROM BacParamSuda..VALOR_MONEDA    
      WHERE vmFecha    = @FECHA_CONTABLE    
        AND vmcodigo   IN(995,997,998)    

    
     INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS    
     VALUES (@FECHA_CONTABLE, 999, 1.0)
    

     INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS    
     SELECT @FECHA_CONTABLE, codigo_moneda , tipo_cambio    
       FROM BacParamSuda..VALOR_MONEDA_CONTABLE     
      WHERE fecha          = @FECHA_CONTABLE    
        AND codigo_moneda  NOT IN(13,994,995,997,998,999)    
        AND tipo_cambio   <> 0.0    
    

     INSERT INTO @TMP_VALOR_MONEDA_ART84_DERIVADOS    
     SELECT @FECHA_CONTABLE
	      , 13
		  , tipo_cambio    
       FROM BacParamSuda..VALOR_MONEDA_CONTABLE       
      WHERE fecha         = @FECHA_CONTABLE    
        AND codigo_moneda = 994   



 Return

 END

GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_I_TBL_ART84_INPWSIBS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_TBL_ART84_INPWSIBS]    
                       @ID_TICKET                    INT
                      ,@COD_ENTIDAD	                 VARCHAR(02)
                      ,@COD_USUARIO                  VARCHAR(20)
                      ,@TIMESTAMP                    VARCHAR(20)
                      ,@rutCliente                   VARCHAR(15)
                      ,@codigoMonedaIBS              VARCHAR(04)
                      ,@montoReserva                 DECIMAL(17,2)
                      ,@montoGarantizado             DECIMAL(17,2)
                      ,@cantidadDiasPermanencia      INT
                      ,@numeroSolicitudSistemaOrigen VARCHAR(25)
                      ,@codigoDeuda                  INT
                      ,@codigoTransaccion            INT
                      ,@codigoProductoIBS            VARCHAR(04)
                      ,@codigoPaisSBIF               INT
                      ,@Indicador                    VARCHAR(01)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INGRESO DE PARAMETROS INPUT CONSULTA WS DE ARTICULO 84      */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO DBO.TBL_ART84_INPWSIBS
	(ID_TICKET                  , COD_ENTIDAD                   , COD_USUARIO    , TIMESTAMP 
	,rutCliente                 , codigoMonedaIBS               , montoReserva   , montoGarantizado 
	,cantidadDiasPermanencia    , numeroSolicitudSistemaOrigen  , codigoDeuda    , codigoTransaccion
    ,codigoProductoIBS          , codigoPaisSBIF                , Indicador)
	VALUES
	(@ID_TICKET                 , @COD_ENTIDAD                  , @COD_USUARIO    , @TIMESTAMP 
	,@rutCliente                , @codigoMonedaIBS              , @montoReserva   , @montoGarantizado 
	,@cantidadDiasPermanencia   , @numeroSolicitudSistemaOrigen , @codigoDeuda    , @codigoTransaccion
    ,@codigoProductoIBS         , @codigoPaisSBIF               , @Indicador)


	  IF @@ERROR != 0 BEGIN
	     RETURN 0
	  END
	  ELSE BEGIN
	     RETURN 1
	  END


  

END

GO

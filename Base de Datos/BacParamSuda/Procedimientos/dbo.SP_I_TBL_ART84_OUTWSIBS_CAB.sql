USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_I_TBL_ART84_OUTWSIBS_CAB]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_TBL_ART84_OUTWSIBS_CAB]    
                       @ID_TICKET                    INT
                      ,@flagCumplimiento             VARCHAR(01)
                      ,@correlativoIngresoIBS        NUMERIC(21)
                      ,@nombreCliente                VARCHAR(45)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INGRESO DE PARAMETROS OUTPUT CONSULTA WS DE ARTICULO 84     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO DBO.TBL_ART84_OUTWSIBS_CAB
	 (ID_TICKET    , flagCumplimiento    , correlativoIngresoIBS    ,nombreCliente )
	VALUES
	 (@ID_TICKET   , @flagCumplimiento   , @correlativoIngresoIBS   ,@nombreCliente )



	  IF @@ERROR != 0 BEGIN
	     RETURN 0
	  END
	  ELSE BEGIN
	     RETURN 1
	  END


  

END

GO

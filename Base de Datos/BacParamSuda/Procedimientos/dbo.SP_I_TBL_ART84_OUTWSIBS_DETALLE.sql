USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_I_TBL_ART84_OUTWSIBS_DETALLE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_TBL_ART84_OUTWSIBS_DETALLE]    
                       @ID_TICKET                INT
                      ,@codigoAlerta             VARCHAR(04) 
                      ,@detalleAlerta            VARCHAR(80)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INGRESO DE PARAMETROS OUTPUT CONSULTA WS DE ARTICULO 84     */
   /*                 DETALLES ALERTAS                                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO DBO.TBL_ART84_OUTWSIBS_DETALE
	 (ID_TICKET   ,codigoAlerta   ,detalleAlerta)
	VALUES
	 (@ID_TICKET  ,@codigoAlerta  ,@detalleAlerta)



	  IF @@ERROR != 0 BEGIN
	     RETURN 0
	  END
	  ELSE BEGIN
	     RETURN 1
	  END


  

END

GO

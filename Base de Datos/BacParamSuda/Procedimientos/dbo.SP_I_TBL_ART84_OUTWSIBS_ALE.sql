USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_I_TBL_ART84_OUTWSIBS_ALE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_TBL_ART84_OUTWSIBS_ALE]    
                       @ID_TICKET                    INT
                      ,@flagAlerta                   VARCHAR(01)
                      ,@codigoAlerta                 VARCHAR(04)
                      ,@descripcionAlerta            VARCHAR(80)

AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INGRESO DE PARAMETROS OUTPUT CONSULTA WS DE ARTICULO 84     */
   /*                 ALERTAS                                                     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO DBO.TBL_ART84_OUTWSIBS_ALE
	 (ID_TICKET   ,flagAlerta   ,codigoAlerta  ,descripcionAlerta)
	VALUES
	 (@ID_TICKET  ,@flagAlerta  ,@codigoAlerta ,@descripcionAlerta)



	  IF @@ERROR != 0 BEGIN
	     RETURN 0
	  END
	  ELSE BEGIN
	     RETURN 1
	  END


  

END

GO

USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_R_ART84_INPWSIBS_OPE_TICK]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_R_ART84_INPWSIBS_OPE_TICK]    
                       @NRO_OPERACION                INT
					  ,@SISTEMA                      VARCHAR(04)


AS    
BEGIN    
    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : SE EXTRAE NUMERO DE OPERACION IBS Y TICKET                  */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @ID_TICKET             INT
	        ,@correlativoIngresoIBS NUMERIC (21,0)


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     IF EXISTS(SELECT 1
	             FROM DBO.TBL_ART84_INPWSIBS_OPE_TICK
		        WHERE NRO_OPERACION        = @NRO_OPERACION
			      AND SISTEMA              = @SISTEMA) BEGIN

		 SELECT @ID_TICKET             = ID_TICKET
		       ,@correlativoIngresoIBS = correlativoIngresoIBS
		   FROM DBO.TBL_ART84_INPWSIBS_OPE_TICK
		  WHERE NRO_OPERACION        = @NRO_OPERACION
			AND SISTEMA              = @SISTEMA

			 IF @@ROWCOUNT = 0 OR @ID_TICKET IS NULL BEGIN
			    SET @ID_TICKET             = -1
				SET @correlativoIngresoIBS = -1
			 END
     END
	 ELSE BEGIN

          SET @ID_TICKET             = -1
		  SET @correlativoIngresoIBS = -1

	 END
	   
   /*-----------------------------------------------------------------------------*/
   /* SALIDA                                                                      */
   /*-----------------------------------------------------------------------------*/
     SELECT @ID_TICKET              AS TICKET
	       ,@correlativoIngresoIBS  AS NRO_IBS


END

GO

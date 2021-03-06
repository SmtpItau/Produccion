USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_I_ART84_INPWSIBS_OPE_TICK]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_I_ART84_INPWSIBS_OPE_TICK]    

                       @ID_TICKET                    INT

                      ,@NRO_OPERACION                INT

					  ,@SISTEMA                      VARCHAR(04)

                      ,@correlativoIngresoIBS        NUMERIC(21,0)



AS    

BEGIN    

    

	SET NOCOUNT ON   





   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/

   /* OBJETIVOS     : INGRESO DE OPERACIONES CON TICKET Y ACTUALIZACION           */

   /* AUTOR         : ROBERTO MORA DROGUETT                                       */

   /* FECHA CRACION : 07/11/2014                                                  */

   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/



  --INSERT INTO DBO.TBL_ART84_INPWSIBS_OPE_TICK

--	     (ID_TICKET    , NRO_OPERACION  ,SISTEMA ,correlativoIngresoIBS)

	--     VALUES

	  --   (@ID_TICKET   , @NRO_OPERACION ,@SISTEMA,@correlativoIngresoIBS)



   /*-----------------------------------------------------------------------------*/

   /* INGRESO DE REGISTROS                                                        */

   /*-----------------------------------------------------------------------------*/

     IF EXISTS(SELECT 1

	             FROM DBO.TBL_ART84_INPWSIBS_OPE_TICK

		        WHERE ID_TICKET             = @ID_TICKET

			--      AND SISTEMA               = @SISTEMA

			--	  AND correlativoIngresoIBS = @correlativoIngresoIBS
				) BEGIN





         UPDATE TBL_ART84_INPWSIBS_OPE_TICK

		    SET NRO_OPERACION         = @NRO_OPERACION 
			, SISTEMA               = @SISTEMA
			, correlativoIngresoIBS = @correlativoIngresoIBS
	      WHERE ID_TICKET             = @ID_TICKET

		    



		     IF @@ERROR != 0 BEGIN

	            RETURN 0

	         END

	         ELSE BEGIN

	            RETURN 1

	         END



     END

	 ELSE BEGIN



         INSERT INTO DBO.TBL_ART84_INPWSIBS_OPE_TICK

	     (ID_TICKET    , NRO_OPERACION  ,SISTEMA ,correlativoIngresoIBS)

	     VALUES

	     (@ID_TICKET   , @NRO_OPERACION ,@SISTEMA,@correlativoIngresoIBS)



		 IF @@ERROR != 0 BEGIN

	        RETURN 0

	     END

	     ELSE BEGIN

	        RETURN 1

	     END



     END

END

GO

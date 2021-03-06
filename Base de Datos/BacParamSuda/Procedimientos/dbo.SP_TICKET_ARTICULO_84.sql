USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TICKET_ARTICULO_84]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[SP_TICKET_ARTICULO_84]


AS    
BEGIN    
    

	SET NOCOUNT ON    

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : SALIDA DE ID POR TRANSACCIONAL                              */
   /* REQUERIMIENTO : PRD -ARTICULO 84                                            */
   /* FECHA CRACION : 07/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @AUX_ID  INT
	        ,@ID      INT



   /*-----------------------------------------------------------------------------*/
   /* SE RESCATA EL ULTIMO NUMERO DE ID POR DEFINICION                            */
   /* IMPORTANTE NUNCA COLOCAR UN WITH NOLOCK SOBRE ESTE SELECT (dirty Read)      */
   /* DEBIDO A QUE NECESITAMOS QUE ESTA TABLA SE ENCUENTRE BLOQUEADA MIENTRAS     */
   /* EXISTA UNA TRANSACCION Y ESTA RESPETE LA EXCLUSION MUTUA                    */
   /*-----------------------------------------------------------------------------*/
     SELECT @AUX_ID    = ID
	   FROM BacParamSuda.DBO.TBL_TICKET_ARTICULO_84








   /*-----------------------------------------------------------------------------*/
   /* COMIENZO DE TRANSACCION                                                     */
   /*-----------------------------------------------------------------------------*/
     BEGIN TRANSACTION 


        SET @AUX_ID    = @AUX_ID + 1 
	 UPDATE BacParamSuda.DBO.TBL_TICKET_ARTICULO_84
	    SET 
		 ID = @AUX_ID
	  


	     IF @@ROWCOUNT = 0 OR @@ERROR != 0 BEGIN
		    ROLLBACK TRANSACTION 
			 SET @ID = -1
		 END
		 ELSE BEGIN
		    COMMIT TRANSACTION 
			SET @ID = @AUX_ID
		 END

		 
		 SELECT @AUX_ID AS TICKET

    
END






GO

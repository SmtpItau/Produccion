USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CODIGOS_FACILITY]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create PROCEDURE [dbo].[SP_UPDATE_CODIGOS_FACILITY]    
                   @Id_sistema           CHAR(03)  
                  ,@Codigo_Producto      CHAR(05)  
                  ,@Codigo_ProductoOtro  CHAR(05)  
                  ,@Codigo_Instrumento   INT 
                  ,@Codigo_Facility      CHAR(04)  
AS    
BEGIN    


    
	SET NOCOUNT ON   


   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : ACTUALIZAR TABLA DE CODIGOS                                 */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 05/11/2015                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     UPDATE DBO.PRODUCTOS_MESA_FACILITY
	    SET Codigo_Facility     = @Codigo_Facility
	  WHERE Id_sistema          = @Id_sistema
	    AND Codigo_Producto     = @Codigo_Producto
		AND Codigo_ProductoOtro = @Codigo_ProductoOtro
		AND Codigo_Instrumento  = @Codigo_Instrumento


END
GO

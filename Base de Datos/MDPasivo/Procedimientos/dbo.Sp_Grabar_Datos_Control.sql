USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Datos_Control]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Grabar_Datos_Control]
      (     @ENTIDAD         CHAR(50),
            @DIRECCION       CHAR(40),
            @COMUNA          NUMERIC(05),
            @CIUDAD          NUMERIC(05),
            @TELEFONO        NUMERIC(10),
            @TIEMPO          NUMERIC(15,2),
            @MAXPAPELETA     NUMERIC(2),
	    @FAX	     CHAR(10),
            @VALIDALINEA     CHAR(1),
	    @PUERTO_UDP	     NUMERIC(05) = 0
      )
AS
BEGIN

SET NOCOUNT ON
SET DATEFORMAT dmy

   -- << UPDATE DATOS_GENERALES >>
   UPDATE DATOS_GENERALES
   SET    Nombre_Entidad	=   @ENTIDAD
   ,      Direccion_Entidad	=   @DIRECCION
   ,      Comuna_Entidad	=   @COMUNA
   ,      Ciudad_Entidad	=   @CIUDAD
   ,      Fono_Entidad		=   @TELEFONO
   ,      Tiempo_Otc		=   @TIEMPO
   ,	  Fax_Entidad		=   @FAX
   ,	  max_papeletas		=   @MAXPAPELETA
   ,      valida_linea          =   @VALIDALINEA
   , 	  puerto_UDP		=   @PUERTO_UDP

   UPDATE ENTIDAD 
   SET rcnombre	  	        = @ENTIDAD


   IF @@ERROR <> 0 BEGIN
      ROLLBACK TRANSACTION
      SELECT -1 , 'ERROR EN LA ACTUALIZACION DE LA TABLA DE DATOS GENERALES'
      RETURN
   END

      SELECT 0 , 'ACTUALIZACION DE TABLA DATOS GENERALES SE REALIZO EN FORMA CORRECTA'


END
GO

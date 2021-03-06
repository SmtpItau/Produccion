USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Gen_Menu]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Carga_Gen_Menu]
            ( 
               @Primera_Vez    CHAR(1)     ,
               @Entidad        CHAR(3)     ,
               @Indice         NUMERIC(3)  ,
               @Nombre_Opcion  CHAR(50)    ,
               @Nombre_Objeto  CHAR(30)    ,
               @Posicion       NUMERIC(3)  ,
               @iInterfaz      NUMERIC(1)
            )
AS
BEGIN


   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF @Primera_Vez = 'S'
   BEGIN

      SELECT *
      INTO ##PRIVILEGIO	
      FROM  PRIVILEGIO 
      WHERE Entidad = @Entidad		

      DELETE PRIVILEGIO WHERE Entidad = @Entidad
      DELETE MENU WHERE Entidad = @Entidad
   END

   IF @@ERROR = 0
   BEGIN  
      INSERT MENU( Entidad,
                       Indice,
                       Nombre_Opcion,
                       Nombre_Objeto,
                       Posicion,
                       EntidadFox )
               VALUES( @Entidad,
                       @Indice,
                       @Nombre_Opcion,
                       @Nombre_Objeto,
                       @Posicion,
                       @iInterfaz )

       INSERT INTO PRIVILEGIO	
       SELECT *
       FROM ##PRIVILEGIO 
       WHERE entidad = @entidad
       AND   opcion =  @nombre_objeto
 	
   END

   SET NOCOUNT OFF

   IF @@ERROR <> 0
   BEGIN

      SELECT 'ERROR'

   END ELSE BEGIN

      SELECT 'OK'

   END
            
END



GO

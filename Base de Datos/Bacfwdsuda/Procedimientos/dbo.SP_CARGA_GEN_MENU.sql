USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GEN_MENU]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CARGA_GEN_MENU]
            ( 
               @Primera_Vez    CHAR(1)     ,
               @Entidad        CHAR(3)     ,
               @Indice         NUMERIC(3)  ,
               @Nombre_Opcion  CHAR(150)    ,
               @Nombre_Objeto  CHAR(30)    ,
               @Posicion       NUMERIC(3)  
            )
AS
BEGIN
   SET NOCOUNT ON
   IF @Primera_Vez = 'S'
   BEGIN
      DELETE VIEW_GEN_MENU WHERE Entidad = 'BFW'
   END
   IF @@ERROR = 0
   BEGIN  
      INSERT VIEW_GEN_MENU( Entidad,
                       Indice,
                       Nombre_Opcion,
                       Nombre_Objeto,
                       Posicion,
                       EntidadFox )
               VALUES( 'BFW',
                       @Indice,
                       @Nombre_Opcion,
                       @Nombre_Objeto,
                       @Posicion,
                       '' )
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

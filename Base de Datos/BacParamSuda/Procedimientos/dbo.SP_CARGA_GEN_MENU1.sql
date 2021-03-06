USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GEN_MENU1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_GEN_MENU1]
            ( 
               @Primera_Vez    CHAR(1)     ,
               @Entidad        CHAR(3)     ,
               @Indice         NUMERIC(3)  ,
               @Nombre_Opcion  CHAR(30)    ,
               @Nombre_Objeto  CHAR(30)    ,
               @Posicion       NUMERIC(3)  
            )
AS
BEGIN
   SET NOCOUNT ON
   IF @Primera_Vez = 'S'
   BEGIN
      DELETE GEN_MENU WHERE Entidad = 'SCF'
   END
   IF @@ERROR = 0
   BEGIN  
      INSERT GEN_MENU( Entidad,
                       Indice,
                       Nombre_Opcion,
                       Nombre_Objeto,
                       Posicion,
                       EntidadFox )
               VALUES( 'SCF',
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
-- select * from sysobjects where name = 'Sp_Carga_Gen_Menu1'
-- select * from sistema_cnt
GO

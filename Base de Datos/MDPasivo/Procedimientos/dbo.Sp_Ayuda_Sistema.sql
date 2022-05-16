USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ayuda_Sistema]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ayuda_Sistema]
        (@Sw           NUMERIC(1),
         @Id_Sistema   CHAR(50)=' ')

AS BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy
        BEGIN
        IF @Sw = 0 BEGIN
	   SELECT nombre_sistema,id_sistema
           FROM SISTEMA_CNT WHERE operativo = 'S' ORDER BY nombre_sistema
	END ELSE
           SELECT nombre_sistema,id_sistema
           FROM SISTEMA_CNT WHERE id_sistema = @Id_Sistema AND
           operativo = 'S' ORDER BY nombre_sistema
        END
   SET NOCOUNT OFF 
END















GO

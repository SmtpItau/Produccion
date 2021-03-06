USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_FormaPago]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Leer_FormaPago]( @Codigo INTEGER = 0 )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

     SELECT codigo     ,
            glosa      ,
            glosa2     ,
            perfil     ,
            codgen     ,
            cc2756     ,
            afectacorr ,
            diasvalor  ,
            numcheque  ,
            ctacte     ,
            Settlement ,
            relacion_bcch,
	    forma_central,
	    Contable
       FROM FORMA_DE_PAGO

      WHERE (codigo = @codigo OR @codigo = 0)
            AND ESTADO<>'A'
END

GO

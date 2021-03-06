USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BorraSinacofiMDCL]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_BorraSinacofiMDCL]( @clrut         NUMERIC(10) ,
                                       @clcodigo      NUMERIC(10) )
AS 

BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


     IF EXISTS (SELECT

		clrut ,
		clcodigo, 
		clnumSinacofi,
		clnomSinacofi
		FROM SINACOFI 
		WHERE clrut = @clrut AND clcodigo = @clcodigo)

     	DELETE FROM SINACOFI 
              WHERE clrut = @clrut AND clcodigo = @clcodigo

END



GO

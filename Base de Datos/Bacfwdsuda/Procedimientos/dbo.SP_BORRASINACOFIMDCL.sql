USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRASINACOFIMDCL]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRASINACOFIMDCL]
         (  @clrut         NUMERIC(10) ,
            @clcodigo      NUMERIC(10) 
         )
AS 
BEGIN
SET NOCOUNT ON
     IF EXISTS (SELECT 1 FROM VIEW_TBSINACOFI WHERE clrut = @clrut AND clcodigo = @clcodigo)
        DELETE FROM VIEW_TBSINACOFI
              WHERE clrut = @clrut AND clcodigo = @clcodigo
SET NOCOUNT OFF
END

GO

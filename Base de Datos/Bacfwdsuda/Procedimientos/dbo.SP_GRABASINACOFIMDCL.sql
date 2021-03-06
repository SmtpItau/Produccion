USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABASINACOFIMDCL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABASINACOFIMDCL](	@clrut         NUMERIC(10) ,
                                       @clcodigo      NUMERIC(10) ,
                                       @clnumSinacofi CHAR(4)     ,
                                       @clnomSinacofi CHAR(4)     )
AS 
BEGIN
SET NOCOUNT ON
     IF NOT EXISTS (SELECT * FROM VIEW_TBSINACOFI WHERE clrut = @clrut AND clcodigo = @clcodigo)
        INSERT INTO VIEW_TBSINACOFI VALUES( @clrut, @clcodigo, @clnumSinacofi, @clnomSinacofi)
     ELSE
        UPDATE VIEW_TBSINACOFI SET clrut         = @clrut, 
                              clcodigo      = @clcodigo, 
                              clnumSinacofi = @clnumSinacofi, 
                              clnomSinacofi = @clnomSinacofi
                        WHERE clrut = @clrut AND clcodigo = @clcodigo
SET NOCOUNT OFF
END

GO

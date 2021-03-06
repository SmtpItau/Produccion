USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[BACMONEDARRDA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BACMONEDARRDA]
       (
        @moneda     VARCHAR(255),
        @sw         NUMERIC(1)
       )
AS
BEGIN
   DECLARE @aux   VARCHAR(255)
   SELECT @aux = 'SELECT mnrrda FROM view_moneda WHERE '
    
   IF @sw = 1 BEGIN
      SELECT @aux = @aux + ' SUBSTRING( mnsimbol, 1, 3 ) = ''' + @moneda + ''''
   END ELSE BEGIN
      SELECT @aux = @aux + 'mncodmon = ' + RTRIM( LTRIM( @moneda ) )
   END
   EXECUTE (@aux)
END

GO

USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMNTMN_ELIMINAR]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BACMNTMN_ELIMINAR]
                  (
                  @codigo NUMERIC(5)
                  )
AS
BEGIN
      SET NOCOUNT ON
      IF EXISTS(SELECT 1 FROM MONEDA WHERE mncodmon = @codigo) BEGIN
            DELETE FROM MONEDA WHERE mncodmon = @codigo
            SELECT 'OK'      
      
      END ELSE BEGIN
            SELECT 'NO'
      END
      SET NOCOUNT OFF
END
GO
